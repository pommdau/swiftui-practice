//
//  ContentView.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import SwiftUI

struct ContentView: View {
    
    private var fontURLs: [URL] {
        
        let fontExtensions: [String] = ["otf", "ttf", "ttc"]
        
        var fontURLs = [URL]()
        
        fontExtensions.forEach { fontExtension in
            if let urls = Bundle.main.urls(forResourcesWithExtension: fontExtension, subdirectory: nil) {
                fontURLs += urls
            }
        }
                        
        return fontURLs
    }
           
    var body: some View {
        
        VStack {
                        
            Text("Hello, world!")
                .padding()
            Button {
            
                fontURLs.forEach { url in
                    print(url.path)
                }
                
                
                CTFontManagerRegisterFontURLs(fontURLs as CFArray, .user, true) { cfarray, result in
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
