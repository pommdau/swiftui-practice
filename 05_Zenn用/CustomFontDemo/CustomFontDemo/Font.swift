//
//  Font.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import Foundation

struct Font {

    var url: URL
    var isInstalled: Bool = false
    
    var fileName: String {
        return url.lastPathComponent
    }
    
}

extension Font {
    
    static func loadBundleResourceFonts() -> [Font] {
        let fontExtensions: [String] = ["otf", "ttf", "ttc"]
        var fontURLs = [URL]()
        fontExtensions.forEach { fontExtension in
            if let urls = Bundle.main.urls(forResourcesWithExtension: fontExtension, subdirectory: nil) {
                fontURLs += urls
            }
        }
        
        return fontURLs.map { Font(url: $0) }
    }
    
}
