//
//  SplitViewDemo.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/28.
//

import SwiftUI

struct SplitViewDemo: View {
    
    // MARK: - Properties
    
    @State private var fonts: [Font] = Font.loadBundleResourceFonts()
        
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Actions").textCase(.none)) {
                    Button {
                    } label: {
                        Text("Install all")
                    }
                    
                    Button {
                    } label: {
                        Text("Uninstall all")
                    }
                    
                    Button {
                    } label: {
                        Text("Open Settings...")
                    }
                }
                Section(header: Text("Fonts").textCase(.none)) {
                    
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
                    
                    NavigationLink {
                        Image(systemName: "key.viewfinder")
                            .resizable()
                            .frame(width: 300, height: 300)
                    } label: {
                        Text("Font2")
                    }
                    
                }
            }
        }
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

struct SplitViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        SplitViewDemo()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
