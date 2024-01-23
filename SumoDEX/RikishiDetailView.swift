//
//  RikishiDetailView.swift
//  SumoDEX
//
//  Created by Mark Strijdom on 23/01/2024.
//

import SwiftUI

struct RikishiDetailView: View {
    let rikishi: Rikishi
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "figure.wrestling")
                    .font(.largeTitle)
                Text(rikishi.currentRank)
                Text(rikishi.debut)
                Text(rikishi.heya)
                Text(rikishi.birthdate)
                Text(rikishi.hometown)
                Text(rikishi.information)
                    .padding()
            }
            .navigationTitle(rikishi.name)
        }
    }
}

#Preview {
    RikishiDetailView(rikishi: Rikishi.example)
}
