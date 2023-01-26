//
//  GesturePropertiesViewTests.swift
//  GuideGesturesTests
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class GesturePropertiesViewTests: XCTestCase {

    func testGesturePropertiesView1() throws {
        let sut = GesturePropertiesView1()
        let rectangle = try sut.inspect().shape(0)
        let gesture = try rectangle.gesture(DragGesture.self).actualGesture()
        XCTAssertEqual(gesture.minimumDistance, 20)
        XCTAssertEqual(gesture.coordinateSpace, .global)
    }

}
