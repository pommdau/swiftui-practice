//
//  ContentView.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import SwiftUI

enum FontHandlingError: Error {
    case installFailed
    case uninstalledFailed
}


struct ContentView: View {
    
    @State private var fonts = Font.loadBundleResourceFonts()
    
    let helper = ContentViewHelper()
    
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
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Install font")
                            Spacer()
                        }
                    }
                    
                    Button {
                        /*
                         fonts.forEach { font in
                         print("\(font.fileName): \(font.isInstalled)")
                         }
                         */
                        
                        updateRegisteredFonts()
                    } label: {
                        HStack {
                            Spacer()
                            Text("show status")
                            Spacer()
                        }
                    }
                    
                    Button {
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)") // Prints true
                            })
                        }
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Open Settings...")
                            Spacer()
                        }
                    }
                }
            }
            .textCase(.lowercase)
        }
        .onAppear {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(helper.fontsChangedNotification(_:)) ,
                name: kCTFontManagerRegisteredFontsChangedNotification as NSNotification.Name,
                object: nil)
            updateRegisteredFonts()
        }
    }
    
    private func updateRegisteredFonts() {
        guard let registeredDescriptors = CTFontManagerCopyRegisteredFontDescriptors(.user, true) as? [CTFontDescriptor] else {
            return
        }
        
        let registeredFontPostNames = createPostNames(fromDescriptors: registeredDescriptors)
        fonts.forEach { font in
            let fontPostNames = createPostNames(fromDescriptors: font.descriptors)
            for fontPostName in fontPostNames {
                for registeredFontPostName in registeredFontPostNames {
                    if registeredFontPostName == fontPostName {
                        font.isInstalled = true
                        break
                    } else {
                        font.isInstalled = false
                    }
                }
            }
        }
    }
    
    private func createPostNames(fromDescriptors descriptors: [CTFontDescriptor]) -> [String] {
        let postNames = descriptors.compactMap { descriptor in
            return CTFontDescriptorCopyAttribute(descriptor, kCTFontNameAttribute) as? String
        }
        
        return postNames
    }
}


//    private func installFonts(fonts: [Font], completion: @escaping (Bool) -> Void) {
//    private func installFonts(fonts: [Font]) -> Result<[Font], FontHandlingError> {
private func installFonts(fonts: [Font]) {
    
    let fontURLs = fonts.map { $0.url } as CFArray
    
    CTFontManagerRegisterFontURLs(fontURLs as CFArray, .user, true) { cfarray, result in
        print("*** result ***")
        print(cfarray)
        if let errors = cfarray as? [Error] {
            print("Stop")
        }
        //            let array: [Error] = cfarray as? [Error] ?? []
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// [Selectors in SwiftUI](https://stackoverflow.com/questions/56867114/selectors-in-swiftui)

class ContentViewHelper {
    @objc func fontsChangedNotification(_ sender: Any) {
        print("Stop")
    }
}
