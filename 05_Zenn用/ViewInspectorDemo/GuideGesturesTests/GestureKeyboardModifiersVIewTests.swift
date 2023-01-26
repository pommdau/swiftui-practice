//
//  GestureKeyboardModifiersVIewTests.swift
//  GuideGesturesTests
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class GestureKeyboardModifiersVIewTests: XCTestCase {
    
#if os(macOS)
    func testGestureModifiers() throws {
        let sut = GestureKeyboardModifiersVIew()
        let gesture = try sut.inspect().shape(0).gesture(TapGesture.self)
        XCTAssertEqual(try gesture.gestureModifiers(), [.shift, .control])
    }
#endif
    
}
