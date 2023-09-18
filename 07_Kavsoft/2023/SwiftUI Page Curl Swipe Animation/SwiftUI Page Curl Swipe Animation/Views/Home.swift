//
//  Home.swift
//  SwiftUI Page Curl Swipe Animation
//
//  Created by HIROKI IKEUCHI on 2023/09/18.
//

import SwiftUI

struct Home: View {
    
    @State private var images: [ImageModel] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                ForEach(images) {
                    CardView($0)
                }
            }
            .padding(15)
        }
        .onAppear {
            for index in 1...4 {
                images.append(.init(assetName: "Pic \(index)"))
            }
        }
    }
    
    @ViewBuilder
    private func CardView(_ imageModel: ImageModel) -> some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                Image(imageModel.assetName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
        }
        .frame(height: 130)
        .contentShape(Rectangle())
    }
}

#Preview {
    ContentView()
}

struct ImageModel: Identifiable {
    var id: UUID = .init()
    var assetName: String
}
