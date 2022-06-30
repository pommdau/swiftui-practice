//
//  ContentView.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import SwiftUI

struct ContentView: View {
    
    private var fonts = Font.loadBundleResourceFonts()
           
    var body: some View {
        
        VStack {
            
            List {
                Section("Target Fonts") {
                    ForEach(fonts, id: \.url) { font in
//                        Toggle(isOn: $font.isInstalled) {
//                            Text(font.fileName)
//                        }
                        Text(font.fileName)
                    }
                }
            }
            
            
            Button {
                handleFonts(fonts: fonts, enabled: true)
            } label: {
                Text("Install font")
            }
            
            Button {
                print("")
            } label: {
                Text("update UI")
            }
            
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
