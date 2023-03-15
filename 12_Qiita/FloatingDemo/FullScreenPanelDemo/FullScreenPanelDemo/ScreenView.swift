//
//  ScreenInfoView.swift
//  FullScreenPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/03/06.
//

import SwiftUI

struct ScreenViewModel: Identifiable {
    let id: String
    let localizedName: String
    let screenFrame: CGRect
    var floatingPanelFrame: CGRect
    
    init(screen: NSScreen, floatingPanelFrame: CGRect) {
        self.id = screen.displayID
        self.localizedName = screen.localizedName
        self.screenFrame = screen.frame
        self.floatingPanelFrame = floatingPanelFrame
    }
    
    static let sampleData = ScreenViewModel(screen: NSScreen.screens.first!, floatingPanelFrame: .zero)
}

struct ScreenView: View {
    
    @Binding var viewModel: ScreenViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.id)
                Text(viewModel.localizedName)
                Text(viewModel.floatingPanelFrame.debugDescription)
            }
            .font(Font.system(size: 20))
            .foregroundColor(.secondary.opacity(0.5))
        }
    }
}

struct ScreenInfoView_Previews: PreviewProvider {
    
    @State private static var viewModel = ScreenViewModel.sampleData
    
    static var previews: some View {
        ScreenView(viewModel: $viewModel)
    }
}
