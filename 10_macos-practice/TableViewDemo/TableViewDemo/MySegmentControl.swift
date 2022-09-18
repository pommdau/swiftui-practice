//
//  MySegmentControl.swift
//  TableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/18.
//

import AppKit
import SwiftUI


struct MySegmentControl: NSViewRepresentable {
    
    enum ButtonStyle: Int {
        case plus = 0
        case minus = 1
    }
    
    private var buttonPressedAction: (Int) -> ()
    
    init(buttonPressedAction: @escaping (Int) -> ()) {
        self.buttonPressedAction = buttonPressedAction
    }
    
    func makeCoordinator() -> MySegmentControl.Coordinator {
        Coordinator(parent: self, buttonPressedAction: buttonPressedAction)
    }
    
    // 一度だけ初期化時に呼ばれる
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
    
    // Updates the state of the specified view controller with new information from SwiftUI.
    func updateNSView(_ nsView: NSSegmentedControl, context: NSViewRepresentableContext<MySegmentControl>) {
        
    }
    
    class Coordinator {
        let parent: MySegmentControl
        private var buttonPressedAction: (Int) -> ()
        
        init(parent: MySegmentControl,
             buttonPressedAction: @escaping (Int) -> ()) {
            self.parent = parent
            self.buttonPressedAction = buttonPressedAction
        }
        @objc
        func onChange(_ control: NSSegmentedControl) {
            print("onChange")
            buttonPressedAction(control.selectedSegment)
        }
    }
}
