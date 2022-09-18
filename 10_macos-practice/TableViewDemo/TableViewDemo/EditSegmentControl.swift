//
//  MySegmentControl.swift
//  TableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/18.
//

import AppKit
import SwiftUI


struct EditSegmentControl: NSViewRepresentable {
    
    enum SegmentType: Int {
        case plus = 0
        case minus = 1
    }
    
    // MARK: - Properties
        
    private var segmentButtonPressed: (SegmentType) -> ()
        
    // MARK: - LifeCycle
        
    init(segmentButtonPressed: @escaping (SegmentType) -> ()) {
        self.segmentButtonPressed = segmentButtonPressed
    }
        
    // MARK: - NSViewRepresentable Methods
    
    func makeCoordinator() -> EditSegmentControl.Coordinator {
        Coordinator(parent: self, segmentButtonPressed: segmentButtonPressed)
    }
    
    // 一度だけ初期化時に呼ばれる
    func makeNSView(context: NSViewRepresentableContext<EditSegmentControl>) -> NSSegmentedControl {
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
    func updateNSView(_ nsView: NSSegmentedControl, context: NSViewRepresentableContext<EditSegmentControl>) {
        
    }
    
    class Coordinator {
        
        // MARK: - Properties
        
        let parent: EditSegmentControl
        private var segmentButtonPressed: (SegmentType) -> ()
        
        // MARK: - LifeCycle
                
        init(parent: EditSegmentControl,
             segmentButtonPressed: @escaping (SegmentType) -> ()) {
            self.parent = parent
            self.segmentButtonPressed = segmentButtonPressed
        }
        
        // MARK: - Helpers
        
        @objc
        func onChange(_ control: NSSegmentedControl) {
            switch control.selectedSegment {
            case SegmentType.plus.rawValue:
                segmentButtonPressed(.plus)
            case SegmentType.minus.rawValue:
                segmentButtonPressed(.minus)
            default:
                break
            }
        }
    }
}
