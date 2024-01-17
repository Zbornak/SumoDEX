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
    
    static func <(lhs: Rikishi, rhs: Rikishi) -> Bool {
        lhs.name < rhs.name
    }
}

struct ContentView: View {
    let testRikishi = [
        Rikishi(name: "Hoshoryu", kanji: "豊昇龍", birthName: "Sugarragchaagiin Byambasuren", nationality: "Mongolian", hometown: "Ulaanbaatar", age: 24, height: 1.87, weight: 140, currentRank: "Ozeki", highestRank: "Ozeki", stable: "Tatsunami", championshipsWon: 2, specialPrizes: ["Technique", "Fighting Spirit"]),
        Rikishi(name: "Endo", kanji: "遠藤聖大", birthName: "Shota Endo", nationality: "Japanese", hometown: "Anamizu", age: 33, height: 1.83, weight: 148, currentRank: "Maegashira", highestRank: "Komusubi", stable: "Oitekaze", championshipsWon: 1, specialPrizes: ["Fighting Spirit", "Technique", "Outstanding Performance"])
    ].sorted()
    
    var body: some View {
        NavigationStack {
            List(testRikishi) { rikishi in
                Text("\(rikishi.name)")
            }
            .navigationTitle("相撲デックス")
        }
    }
}

#Preview {
    ContentView()
}
