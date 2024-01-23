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
                ZStack {
                    Image(systemName: "oval").font(.system(size: 86)).offset(x: 0, y: 8)
                    HStack {
                        Image(systemName: "figure.wrestling")
                            .font(.largeTitle)
                        Image(systemName: "figure.wrestling").scaleEffect(CGSize(width: -1.0, height: 1.0))
                            .font(.largeTitle)
                    }
                }
                .padding()
                
                Text("Current rank:").fontWeight(.bold)
                Text(rikishi.currentRank).padding(.bottom)
                
                Text("Debut:").fontWeight(.bold)
                Text(rikishi.debut).padding(.bottom)
                
                Text("Heya:").fontWeight(.bold)
                Text(rikishi.heya).padding(.bottom)
                
                Text("Birthdate:").fontWeight(.bold)
                Text(rikishi.birthdate).padding(.bottom)
                
                Text("Hometown:").fontWeight(.bold)
                Text(rikishi.hometown).padding(.bottom)
                
                Text("Information").fontWeight(.bold)
                Text(rikishi.information).multilineTextAlignment(.center)
                
            }
            .padding()
            .navigationTitle(rikishi.name)
        }
    }
}

#Preview {
    RikishiDetailView(rikishi: Rikishi.example)
}
