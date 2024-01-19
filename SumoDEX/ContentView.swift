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

struct ContentView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
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
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                    .font(.headline)
                                }
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
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&titles=List_of_active_sumo_wrestlers&prop=revisions&rvprop=content&format=json"
        guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted { $0.title < $1.title }
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
    }
}

#Preview {
    ContentView()
}
