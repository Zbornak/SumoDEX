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
            ZStack {
                Image("gyoji").resizable().scaledToFill().opacity(0.2).blur(radius: 3.0)
                VStack {
                    HStack {
                        Image(systemName: "figure.wrestling").font(.largeTitle)
                        Image(systemName: "figure.wrestling")
                            .scaleEffect(CGSize(width: -1.0, height: 1.0))
                            .font(.largeTitle)
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
                .toolbar {
                    Button {
                        // add to favourites
                    } label: {
                        HStack {
                            Image(systemName: rikishi.isFavourite == false ? "arrow.down.heart" : "suit.heart.fill")
                            Text(rikishi.isFavourite == false ? "Add to favourites" : "Favourite")
                        }
                    }
                }
            }
            .padding()
            .navigationTitle(rikishi.name)
        }
    }
}

#Preview {
    RikishiDetailView(rikishi: Rikishi.example)
}
