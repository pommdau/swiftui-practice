//
//  Modifier+Extension.swift
//  FloatingWindowDemo
//
//  Created by HIROKI IKEUCHI on 2023/02/27.
//

import SwiftUI

struct FloatingPanelModifier: ViewModifier {
    
    @ViewBuilder fileprivate let view: any View
    @Binding var viewModel: ScreenViewModel
    
    @State private var panel: FloatingPanel?
    @State private var floatingWindowController = FloatingPanelController()
    
    func body(content: Content) -> some View {
        Color.clear  // unused
            .onAppear {
                let panel = FloatingPanel(view: view, contentRect: NSRectFromCGRect(viewModel.floatingPanelFrame))
                panel.delegate = floatingWindowController
                panel.orderFront(nil)
                panel.makeKey()
                floatingWindowController.window = panel
                floatingWindowController.windowDidMoveHandler = { window in
                    guard let window else { return }
                    viewModel.floatingPanelFrame = window.frame
                }
            }
    }
}

extension View {
    func floatingPanel(viewModel: Binding<ScreenViewModel>) -> some View {
        Color.clear  // unused
            .modifier(FloatingPanelModifier(view: { self },
                                            viewModel: viewModel))
    }
}
