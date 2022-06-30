//
//  ContentView.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var fonts = Font.loadBundleResourceFonts()
    
    var body: some View {
        
        VStack {
            
            List {
                Section("Target Fonts") {
                    ForEach(fonts.indices, id: \.self) { index in
                        Toggle(isOn: $fonts[index].isInstalled) {
                            Text(fonts[index].fileName)
                        }
                    }
                }
                
                Section("Actions") {
                    Button {
                        handleFonts(fonts: fonts, enabled: true)
                    } label: {
                        HStack {
                            Spacer()
                            Text("Install font")
                            Spacer()
                        }
                    }
                    
                    Button {
                        fonts.forEach { font in
                            print("\(font.fileName): \(font.isInstalled)")
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("show status")
                            Spacer()
                        }
                    }
                }
            }
            .textCase(.lowercase)
        }
    }
    
    private func handleFonts(fonts: [Font], enabled: Bool) {
        let fontURLs = fonts.map { $0.url } as CFArray
        CTFontManagerRegisterFontURLs(fontURLs as CFArray, .user, enabled) { cfarray, result in
            print(cfarray)
            print(result)
            return true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
