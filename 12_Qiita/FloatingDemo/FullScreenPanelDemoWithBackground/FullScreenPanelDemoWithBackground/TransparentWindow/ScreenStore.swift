//
//  TransparentScreenStore.swift
//  FullScreenPanelDemoWithBackground
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import Foundation

class ScreenStore: ObservableObject {
    @Published var screens: [Screen] = []
}
