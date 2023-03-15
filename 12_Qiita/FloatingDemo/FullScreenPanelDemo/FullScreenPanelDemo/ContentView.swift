//
//  ContentView.swift
//  FullScreenPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/02/28.
//

import SwiftUI

struct ContentView: View {
        
    @State private var viewModels: [ScreenViewModel] = []  // it does'nt work...
    @State private var viewModel = ScreenViewModel(screen: NSScreen.screens.first!, floatingPanelFrame: .zero)  // it works
        
    var body: some View {
        ZStack {
            Button("Update FullScreen Panels") {
                updateScreens()
            }
            
            ForEach($viewModels) { $viewModel in
                ScreenView(viewModel: $viewModel)
                    .floatingPanel(viewModel: $viewModel)
            }
            
            ScreenView(viewModel: $viewModel)
                .floatingPanel(viewModel: $viewModel)
        }
        .padding()
        .onAppear() {
            updateScreens()
        }
    }
    
    private func updateScreens() {
        let viewModels = NSScreen.screens.map({ screen in
            let frame = CGRect(x: screen.frame.origin.x, y: screen.frame.origin.y, width: 300, height: 300)
            return ScreenViewModel(screen: screen,
                                   floatingPanelFrame: frame)
        })
        self.viewModel = viewModels[0]
        self.viewModels = viewModels
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

