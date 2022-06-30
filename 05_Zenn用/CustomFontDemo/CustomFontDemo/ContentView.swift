//
//  ContentView.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import SwiftUI

struct ContentView: View {
    
    private var fontURLs: CFArray {
        
        let fontNames: [String] = ["", "", ""]
        
        let fontURLs: [URL] = fontNames.compactMap { fontName in
            if let resource = Bundle.main.resourceURL {
                return resource.appendingPathComponent(fontName)
            } else {
                return nil
            }
        }
        
        return fontURLs as CFArray
    }
           
    var body: some View {
        
        VStack {
                        
            Text("Hello, world!")
                .padding()
            Button {
                                
                CTFontManagerRegisterFontURLs(self.fontURLs, .user, true) { cfarray, result in
                    print(cfarray)
                    print(result)
                    return true
                }
                
//                CTFontManagerRegisterFontsWithAssetNames(
//                    ["NikkyouSans-mLKax"] as CFArray,
//                    nil, .user, true, { arr, result in
//                        print(arr)
//                        print(result)
//                        return true
//                    })
            } label: {
                Text("Install font")
            }
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
