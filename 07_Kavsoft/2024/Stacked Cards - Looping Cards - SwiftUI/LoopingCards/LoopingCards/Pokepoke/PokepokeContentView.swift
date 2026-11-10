//
//  PokepokeContentView.swift
//  LoopingCards
//
//  Created by HIROKI IKEUCHI on 2026/01/07.
//

import SwiftUI

struct PokepokeContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { proxy in
                    let width = proxy.size.width
                    LoopingStackPokepoke(maxTranslationWidth: width) {
                        ForEach(images) { image in
                            Image(image.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 400)
                                .padding(5)
                                .shadow(radius: 2)
                            
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 420)
            }
            .navigationTitle("Looping Stack")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.2))
        }
    }
}

#Preview {
    PokepokeContentView()
}
