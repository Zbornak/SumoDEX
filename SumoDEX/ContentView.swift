//
//  ContentView.swift
//  SumoDEX
//
//  Created by Mark Strijdom on 17/01/2024.
//

import SwiftSoup
import SwiftUI

struct Rikishi: Comparable, Identifiable {
    let id = UUID()
    var name: String
    
    static func <(lhs: Rikishi, rhs: Rikishi) -> Bool {
        lhs.name < rhs.name
    }
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var rikishiInfoArray = [String]()
    
    var searchResults: [String] {
            if searchText.isEmpty {
                return filterArrayForNames(from: rikishiInfoArray)
            } else {
                return filterArrayForNames(from: rikishiInfoArray).filter { $0.contains(searchText) }
            }
        }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { rikishi in
                    Text(rikishi)
                }
            }
            .navigationTitle("相撲デックス")
            .searchable(text: $searchText)
            .task {
                await rikishiInfoArray = fetchActiveRikishiData()
            }
        }
    }
    
    func fetchActiveRikishiData() async -> [String] {
        if let url = URL(string: "https://en.wikipedia.org/wiki/List_of_active_sumo_wrestlers") {
            do {
                let contents = try String(contentsOf: url)
                let document: Document = try SwiftSoup.parse(contents)
                guard let body = document.body() else { return ["Error: Body could not be loaded."] }
                let table = try body.getElementsByTag("td")
                for tableEntry in table {
                    try rikishiInfoArray.append(tableEntry.text())
                }
            } catch {
                return ["Error: Contents could not be loaded."]
            }
        } else {
            return ["Error: Bad URL."]
        }
        
        return filterArrayForNames(from: rikishiInfoArray)
    }
    
    func filterArrayForNames(from arrayToFilter: [String]) -> [String] {
        do {
            let kanji = try Regex("[\u{4E00}-\u{9FFF}\u{3000}-\u{303F}]")
            let newArray = arrayToFilter.filter { $0.contains(kanji) }
            return newArray
        } catch {
            return ["Error: REGEX filtering failed"]
        }
    }
}

#Preview {
    ContentView()
}
