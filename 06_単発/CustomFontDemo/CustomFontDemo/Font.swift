//
//  Font.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import Foundation
import CoreText

struct Font {
    
    var url: URL
    var isInstalled: Bool = false
    var descriptor: CTFontDescriptor
    
    var fileName: String {
        return url.lastPathComponent
    }
    
    var familyName: String {
        let font = CTFontCreateWithFontDescriptor(descriptor, 0.0, nil)
        return CTFontCopyFamilyName(font) as String
    }
    
    
    init(url: URL, isInstalled: Bool = false, descriptor: CTFontDescriptor) {
        self.url = url
        self.isInstalled = isInstalled
        self.descriptor = descriptor
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
        
        var fonts = [Font]()
        for fontURL in fontURLs {
            guard let descriptors = CTFontManagerCreateFontDescriptorsFromURL(fontURL as CFURL) as? [CTFontDescriptor]
            else {
                continue
            }
            
            for descriptor in descriptors {
                fonts.append(Font(url: fontURL, descriptor: descriptor))
            }
        }
        
        return fonts
    }
}
