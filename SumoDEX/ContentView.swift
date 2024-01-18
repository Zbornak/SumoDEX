//
//  ContentView.swift
//  SumoDEX
//
//  Created by Mark Strijdom on 17/01/2024.
//

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

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let page: Page
}

struct Page: Codable {
    let pageid: Int
    let title: String
}

struct ContentView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var loadingState = LoadingState.loading
    
    let testRikishi = [
        Rikishi(name: "Hoshoryu", kanji: "豊昇龍", birthName: "Sugarragchaagiin Byambasuren", nationality: "Mongolian", hometown: "Ulaanbaatar", age: 24, height: 1.87, weight: 140, currentRank: "Ozeki", highestRank: "Ozeki", stable: "Tatsunami", championshipsWon: 2, specialPrizes: ["Technique", "Fighting Spirit"], notes: ""),
        Rikishi(name: "Endo", kanji: "遠藤聖大", birthName: "Shota Endo", nationality: "Japanese", hometown: "Anamizu", age: 33, height: 1.83, weight: 148, currentRank: "Maegashira", highestRank: "Komusubi", stable: "Oitekaze", championshipsWon: 1, specialPrizes: ["Fighting Spirit", "Technique", "Outstanding Performance"], notes: "")
    ].sorted()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Active Rikishi") {
                    switch loadingState {
                    case .loaded:
                        Text("Loaded")
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("相撲デックス")
        }
        .task {
            await fetchActiveRikishi()
        }
    }
    
    func fetchActiveRikishi() async {
        let urlString = "https://en.wikipedia.org/w/api.php?format=json&origin=*&action=query&prop=extracts&explaintext=true&exintro&titles=List+of+active+sumo+wrestlers"
        print(urlString)
    }
}

#Preview {
    ContentView()
}
