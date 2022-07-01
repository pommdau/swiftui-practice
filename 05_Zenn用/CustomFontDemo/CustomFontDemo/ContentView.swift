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
                        }.onChange(of: fonts[index].isInstalled) { newValue in
                            if newValue {
                                installFonts(fonts: [fonts[index]])
                            } else {
                                uninstallFonts(fonts: [fonts[index]])
                            }
                        }
                    }
                }
                
                Section("Actions") {
                    Button {
                        installFonts(fonts: fonts)
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
    
    //    private func installFonts(fonts: [Font], completion: @escaping (Bool) -> Void) {
    private func installFonts(fonts: [Font]) {
        let fontURLs = fonts.map { $0.url } as CFArray
        
        CTFontManagerRegisterFontURLs(fontURLs as CFArray, .user, true) { cfarray, result in
            print("*** result ***")
            print(cfarray)
            print(result)
            return true  // Return NO from the block to stop the registration operation, like after receiving an error.
        }
    }
    
    private func uninstallFonts(fonts: [Font]) {
        let fontURLs = fonts.map { $0.url } as CFArray
        
        CTFontManagerUnregisterFontURLs(fontURLs as CFArray, .user) { cfarray, result in
            print("*** result ***")
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
