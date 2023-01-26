//
//  GestureModifiersViewTests.swift
//  GuideGesturesTests
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class GestureModifiersViewTests: XCTestCase {

    // Gestureがあるかどうかのテスト
    func testGestureModifiersView() throws {
        let sut = GestureModifiersView1()
        let rectangle = try sut.inspect().shape()
        XCTAssertNoThrow(try rectangle.gesture(TapGesture.self))
    }
    
    func testHighPriorityGestureModifier() throws {
        let sut = GestureModifiersView2()
        let rectangle = try sut.inspect().shape(0)
        XCTAssertNoThrow(try rectangle.highPriorityGesture(TapGesture.self))
    }

    func testSimultaneousGestureModifier() throws {
        let sut = GestureModifiersView3()
        let rectangle = try sut.inspect().shape(0)
        XCTAssertNoThrow(try rectangle.simultaneousGesture(TapGesture.self))
    }
}
