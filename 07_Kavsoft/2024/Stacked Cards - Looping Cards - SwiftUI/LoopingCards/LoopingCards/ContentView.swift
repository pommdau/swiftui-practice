//
//  ContentView.swift
//  LoopingCards
//
//  Created by HIROKI IKEUCHI on 2026/01/06.
//

import SwiftUI

struct ImageModel: Identifiable {
    var id: String = UUID().uuidString
    var altText: String
    var image: String
}

let images: [ImageModel] = [
    .init(altText: "Mo Eid", image: "pic1"),
    .init(altText: "Codioful", image: "pic2"),
    .init(altText: "Cottonbro", image: "pic3"),
    .init(altText: "Anni", image: "pic4")
]


struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { proxy in
                    let width = proxy.size.width
                    LoopingStack(maxTranslationWidth: width) {
                        ForEach(images) { image in
                            Image(image.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 250, height: 400)
                                .clipShape(.rect(cornerRadius: 30))
                                .padding(5)
                                .background {
                                    RoundedRectangle(cornerRadius: 35)
                                        .fill(.background)
                                }
                            
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
    ContentView()
}
