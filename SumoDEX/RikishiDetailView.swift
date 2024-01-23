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
        Text(rikishi.name)
    }
}

#Preview {
    RikishiDetailView(rikishi: Rikishi.example)
}
