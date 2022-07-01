//
//  Font.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import Foundation
import CoreText

class Font: ObservableObject {
    
    let url: URL
    @Published var isInstalled: Bool = false
    let descriptors: [CTFontDescriptor]
    
    var fileName: String {
        return url.lastPathComponent
    }
    
    init(url: URL, isInstalled: Bool = false, descriptors: [CTFontDescriptor]) {
        self.url = url
        self.isInstalled = isInstalled
        self.descriptors = descriptors
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
        
        return fontURLs.compactMap { fontURL in
            guard let descriptors = CTFontManagerCreateFontDescriptorsFromURL(fontURL as CFURL) as? [CTFontDescriptor]
            else {
                return nil
            }
            return Font(url: fontURL, descriptors: descriptors)
        }
    }
}
