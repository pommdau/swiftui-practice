//
//  ContentView.swift
//  iOS_Academy
//
//  Created by HIROKI IKEUCHI on 2022/08/11.
//

import SwiftUI

struct Option: Hashable {
    let title: String
    let imageName: String
}

struct ContentView: View {
    
    @State var currentOption = 0
    
    let options: [Option] = [
        .init(title: "Home", imageName: "house"),
        .init(title: "About", imageName: "info.circle"),
        .init(title: "Settings", imageName: "gear"),
        .init(title: "Social", imageName: "message"),
    ]
    
    var body: some View {
        NavigationView {
            ListView(options: options,
            currentSelection: $currentOption)
            
            switch currentOption {
            case 1:
                Text("About iOS Academy View")
            default:
                MainView()
            }
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct ListView: View {
    let options: [Option]
    @Binding var currentSelection: Int
    
    var body: some View {
        VStack {
            
            let current = options[currentSelection]
            
            ForEach(options, id: \.self) { option in
                HStack {
                    Image(systemName: option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text(option.title)
                        .foregroundColor(current == option ? Color(.linkColor) : Color(.labelColor))
                                        
                    Spacer()
                }
                .padding(8)
                .onTapGesture {
                    // TODO: fix Hard Coding
                    if currentSelection == 1 {
                        self.currentSelection = 0
                    } else {
                        self.currentSelection = 1
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct MainView: View {
    
    let cols: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]
    
    let videoImages: [String] = Array(1...6).map { "video\($0)" }
    
    var body: some View {
        VStack {
            Image("header")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            LazyVGrid(columns: cols) {
                ForEach(videoImages, id: \.self) { imageName in
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
