//
//  ContentView.swift
//  FullScreenPanelDemoWithBackground
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var screenStore: ScreenStore
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        VStack {
            Button("Open TransparentScreens") {
                openTransparentScreens()
            }
        }
        .onAppear() {
            openTransparentScreens()
        }
    }
        
    private func openTransparentScreens() {
        screenStore.screens = []
        for screen in NSScreen.screens {
            screenStore.screens.append(
                Screen(screen: screen, floatingPanelFrame: screen.frame)
            )
//            break  // デバッグのためメイン画面のみ取得
        }
        screenStore.screens.forEach { screen in
            openWindow(value: screen.id)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
