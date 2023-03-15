//
//  VisualEffectView.swift
//  FloatingPanelDemo
//
//  Created by HIROKI IKEUCHI on 2023/03/06.
//

import SwiftUI
 
/// Bridge AppKit's NSVisualEffectView into SwiftUI
struct VisualEffectView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode = .behindWindow
    var state: NSVisualEffectView.State = .active
    var emphasized: Bool = true
 
    func makeNSView(context: Context) -> NSVisualEffectView {
        context.coordinator.visualEffectView
    }
 
    func updateNSView(_ view: NSVisualEffectView, context: Context) {
        context.coordinator.update(
            material: material,
            blendingMode: blendingMode,
            state: state,
            emphasized: emphasized
        )
    }
 
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
 
    class Coordinator {
        let visualEffectView = NSVisualEffectView()
 
        init() {
            visualEffectView.blendingMode = .withinWindow
        }
 
        func update(material: NSVisualEffectView.Material,
                        blendingMode: NSVisualEffectView.BlendingMode,
                        state: NSVisualEffectView.State,
                        emphasized: Bool) {
            visualEffectView.material = material
            visualEffectView.blendingMode = blendingMode
            visualEffectView.state = state
            visualEffectView.isEmphasized = emphasized
        }
    }
  }
