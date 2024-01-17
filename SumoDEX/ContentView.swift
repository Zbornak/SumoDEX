//
//  ContentView.swift
//  SumoDEX
//
//  Created by Mark Strijdom on 17/01/2024.
//

import SwiftUI

struct Rikishi: Identifiable {
    let id = UUID()
    var name: String
    var birthName: String
    var nationality: String
    var hometown: String
    var age: Int
    var weight: Int
    var currentRank: String
    var highestRank: String
    var stable: String
}

struct ContentView: View {
    var activeRikishiList = ["Gonoyama", "Terunofuji", "Ura", "Hoshoryu"]
    
    var body: some View {
        NavigationStack {
            List(activeRikishiList, id: \.self) {
                Text($0)
            }
            .navigationTitle("相撲デクス")
        }
    }
}

#Preview {
    ContentView()
}
