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
    var kanji: String
    var birthName: String
    var nationality: String
    var hometown: String
    var age: Int
    var height: Double
    var weight: Int
    var currentRank: String
    var highestRank: String
    var stable: String
    var championshipsWon : Int
    var specialPrizes: [String]
    var notes: String
    
    static func <(lhs: Rikishi, rhs: Rikishi) -> Bool {
        lhs.name < rhs.name
    }
}

struct ContentView: View {
    
    let testRikishi = [
        Rikishi(name: "Hoshoryu", kanji: "豊昇龍", birthName: "Sugarragchaagiin Byambasuren", nationality: "Mongolian", hometown: "Ulaanbaatar", age: 24, height: 1.87, weight: 140, currentRank: "Ozeki", highestRank: "Ozeki", stable: "Tatsunami", championshipsWon: 2, specialPrizes: ["Technique", "Fighting Spirit"], notes: ""),
        Rikishi(name: "Endo", kanji: "遠藤聖大", birthName: "Shota Endo", nationality: "Japanese", hometown: "Anamizu", age: 33, height: 1.83, weight: 148, currentRank: "Maegashira", highestRank: "Komusubi", stable: "Oitekaze", championshipsWon: 1, specialPrizes: ["Fighting Spirit", "Technique", "Outstanding Performance"], notes: "")
    ].sorted()
    
    @State private var rikishiInfoArray = [String]()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Active Rikishi") {
                    List {
                        Text("hello")
                    }
                }
            }
            .navigationTitle("相撲デックス")
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
        
        return rikishiInfoArray
    }
}

#Preview {
    ContentView()
}
