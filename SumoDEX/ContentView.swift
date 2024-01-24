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
    var currentRank: String
    var debut: String
    var heya: String
    var birthdate: String
    var hometown: String
    var information: String
    var isFavourite: Bool
    
    static var example = Rikishi(name: "Abi Masatora", currentRank: "West Maegashira #2", debut: "2013-5", heya: "Shikoroyama", birthdate: "May 4, 1994 (age 29)", hometown:"Saitama", information: "one-time sekiwake, known for distinctive tsuppari, won successive lower division championships after a three tournament suspension for repeatedly breaking COVID-19 rules", isFavourite: false)
    
    // sort Rikishi alphabeically
    static func <(lhs: Rikishi, rhs: Rikishi) -> Bool {
        lhs.name < rhs.name
    }
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var rikishiInfoArray = [String]()
    
    // filter Rikishi list by user search text, or show entire list
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
                    NavigationLink {
                        // pass individual Rikishi name into the getRikishiInfo function to get the corresponding details for that Rikishi
                        RikishiDetailView(rikishi: getRikishiInfo(for: rikishi))
                    } label: {
                        Text(rikishi)
                    }
                }
            }
            .navigationTitle("❀相撲デックス")
            .searchable(text: $searchText)
            .listStyle(.grouped) // remove spaces at the sides of the list
            .task {
                await rikishiInfoArray = fetchActiveRikishiData() // load array data from Wikipedia as soon as the app starts
            }
        }
    }
    
    // scrape Wikipedia page to get table with list of active Rikishi, including basic info
    func fetchActiveRikishiData() async -> [String] {
        if let url = URL(string: "https://en.wikipedia.org/wiki/List_of_active_sumo_wrestlers") {
            do {
                let contents = try String(contentsOf: url) // get source HTML from above address
                let document: Document = try SwiftSoup.parse(contents) // parse the contents into a readable format using SwiftSoup
                guard let body = document.body() else { return ["Error: Body could not be loaded."] }
                let table = try body.getElementsByTag("td") // get all information found in the active Rikishi table
                for tableEntry in table {
                    try rikishiInfoArray.append(tableEntry.text()) // append each result into the rikishiInfo array as a separate element
                }
            } catch {
                return ["Error: Contents could not be loaded."]
            }
        } else {
            return ["Error: Bad URL."]
        }
        
        return rikishiInfoArray
    }
    
    // get only the Rikishi names from the rikishiInfoArray
    func filterArrayForNames(from arrayToFilter: [String]) -> [String] {
        do {
            // only return results which contain Japanese kanji (only the Rikishi names have included kanji)
            let kanji = try Regex("[\u{4E00}-\u{9FFF}\u{3000}-\u{303F}]") // UTF-8 locations of Japanese/Chinese characters
            let newArray = arrayToFilter.filter { $0.contains(kanji) }
            return newArray
        } catch {
            return ["Error: Filtering failed."]
        }
    }
    
    // get Rikishi information from the rikishiInfoArray and create a new struct instance for each Rikishi to display in detail view
    func getRikishiInfo(for rikishiName: String) -> Rikishi {
        var rikishi = Rikishi(name: "", currentRank: "", debut: "", heya: "", birthdate: "", hometown: "", information: "", isFavourite: false)
        // set the index to where the name of the specific Rikishi occurs so that we can access the information that follows in the contiguous indices
        if let index = rikishiInfoArray.firstIndex(where: { $0 == rikishiName }) {
            if index > 0 { // avoid fatal error by going out of range of the rikishiInfoArray
                rikishi.name = rikishiInfoArray[index]
                rikishi.currentRank = rikishiInfoArray[index + 1]
                rikishi.debut = rikishiInfoArray[index + 2]
                rikishi.heya = rikishiInfoArray[index + 3]
                rikishi.birthdate = rikishiInfoArray[index + 4]
                rikishi.hometown = rikishiInfoArray[index + 5]
                rikishi.information = rikishiInfoArray[index + 6]
            }
        }
        
        return rikishi
    }
}

#Preview {
    ContentView()
}
