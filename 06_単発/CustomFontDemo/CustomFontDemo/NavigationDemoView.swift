//
//  NavigationDemoView.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/28.
//

import SwiftUI

struct NavigationDemoView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink {
                    Image(systemName: "camera.macro")
                        .resizable()
                        .frame(width: 300, height: 300)
                } label: {
                    FontRow(name: "Font1")
                }
                
                NavigationLink {
                    Image(systemName: "key.viewfinder")
                        .resizable()
                        .frame(width: 300, height: 300)
                } label: {
                    Text("Font2")
                }
            }
            .navigationBarTitle("Fonts", displayMode: .large)
        }
        .padding(0.5)
    }
}

struct FontRow: View {
    
    var name: String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
        }
    }
}


struct NavigationDemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDemoView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
