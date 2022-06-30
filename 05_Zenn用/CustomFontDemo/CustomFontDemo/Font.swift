//
//  Font.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import Foundation

class Font: ObservableObject {

    var url: URL
    @Published var isInstalled: Bool = false
    
    var fileName: String {
        return url.lastPathComponent
    }
    
    init(url: URL, isInstalled: Bool = false) {
        self.url = url
        self.isInstalled = isInstalled
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
