//
//  MySegmentControl.swift
//  TableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/18.
//

import AppKit
import SwiftUI


struct MySegmentControl: NSViewRepresentable {
    
    func makeCoordinator() -> MySegmentControl.Coordinator {
        Coordinator(parent: self)
    }
    func makeNSView(context: NSViewRepresentableContext<MySegmentControl>) -> NSSegmentedControl {
        let control = NSSegmentedControl(
            images: [
                NSImage(systemSymbolName: "plus", accessibilityDescription: "plus")!,
                NSImage(systemSymbolName: "minus", accessibilityDescription: "minus")!,
            ],
            trackingMode: .momentary,
            target: context.coordinator,
            action: #selector(Coordinator.onChange(_:))
        )
        return control
    }
    func updateNSView(_ nsView: NSSegmentedControl, context: NSViewRepresentableContext<MySegmentControl>) {
    }
    class Coordinator {
        let parent: MySegmentControl
        init(parent: MySegmentControl) {
            self.parent = parent
        }
        @objc
        func onChange(_ control: NSSegmentedControl) {
        }
    }
}
