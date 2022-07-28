//
//  ContentView.swift
//  CustomFontDemo
//
//  Created by HIROKI IKEUCHI on 2022/06/30.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var fonts: [Font] = Font.loadBundleResourceFonts()
    let helper = ContentViewHelper()
    
    // MARK: - View
    
    var body: some View {
        HStack {
            VStack {
                List {
                    
                    Section(header: Text("Actions").textCase(.none)) {
                        Button {
                            installFonts(fonts: fonts)
                            updateFontStatus()  // TODO: Data-Bindingでできるはず
                        } label: {
                            Text("Install all")
                        }
                        
                        Button {
                            uninstallFonts(fonts: fonts)
                            updateFontStatus()  // TODO: Data-Bindingでできるはず
                        } label: {
                            Text("Uninstall all")
                        }
                        
                        Button {
                            openSettings()
                        } label: {
                            HStack {
                                Text("Open Settings...")
                            }
                        }
                    }
                    
                    Section(header: Text("Fonts").textCase(.none)) {
                        ForEach(fonts.indices, id: \.self) { index in
                            Toggle(isOn: $fonts[index].isInstalled) {
                                Text(fonts[index].familyName)
                            }.onChange(of: fonts[index].isInstalled) { newValue in
                                if newValue {
                                    installFonts(fonts: [fonts[index]])
                                } else {
                                    uninstallFonts(fonts: [fonts[index]])
                                }
                                updateFontStatus()  // TODO: Data-Bindingでできるはず
                            }
                        }
                    }
                }
            }
            Rectangle()
                .foregroundColor(.gray)
        }
        .onAppear {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(helper.fontsChangedNotification(_:)) ,
                name: kCTFontManagerRegisteredFontsChangedNotification as NSNotification.Name,
                object: nil)
            updateFontStatus()
        }
    }
    
    private static func createPostNames(fromDescriptors descriptors: [CTFontDescriptor]) -> [String] {
        let postNames = descriptors.compactMap { descriptor in
            return CTFontDescriptorCopyAttribute(descriptor, kCTFontNameAttribute) as? String
        }
        
        return postNames
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

extension ContentView {
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
    
    private func updateFontStatus() {
        guard let registeredDescriptors = CTFontManagerCopyRegisteredFontDescriptors(.user, true) as? [CTFontDescriptor] else {
            return
        }
        
        let registeredFontPostNames = Self.createPostNames(fromDescriptors: registeredDescriptors)
        
        for index in fonts.indices {
//            let fontPostNames = Self.createPostNames(fromDescriptors: fonts[index].descriptors)
//            for fontPostName in fontPostNames {
//                var isInstalled = false
//                // インストールされたフォントに該当するものがないか確認
//                for registeredFontPostName in registeredFontPostNames {
//                    if registeredFontPostName == fontPostName {
//                        isInstalled = true
//                        break
//                    }
//                }
//                fonts[index].isInstalled = isInstalled
//            }
        }
    }
    
    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
}
