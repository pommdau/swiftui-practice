//
//  ScreenView.swift
//  FullScreenPanelDemoWithBackground
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import SwiftUI

struct ScreenView: View {
    
    let screen: Screen
    
    var body: some View {
        VStack {
            Text("\(screen.id)")
            Text(screen.localizedName)
            Text(screen.floatingPanelFrame.debugDescription)
        }
        .font(Font.system(size: 30))
    }
}

struct TransparentScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(screen: Screen.sampleData())
    }
}

