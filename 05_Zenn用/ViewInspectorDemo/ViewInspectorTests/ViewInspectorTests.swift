//
//  ViewInspectorTests.swift
//  ViewInspectorTests
//
//  Created by HIROKI IKEUCHI on 2022/12/23.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ViewInspectorDemo

class ViewInspectorTests: XCTestCase {

    func testViewInspectorBaseline() throws {
      let expected = "it lives!"
      let sut = Text(expected)
      let value = try sut.inspect().text().string()
      XCTAssertEqual(value, expected)
    }
}

// The Basics

extension TheBasicsView: Inspectable { }  // Extend your view to conform to Inspectable in the test target scope.

final class TheBasicsViewTests: XCTestCase {

    func testStringValue() throws {
        let sut = TheBasicsView()
        let value = try sut.inspect().text().string()
        XCTAssertEqual(value, "Hello, World!")
    }
}

extension MyView: Inspectable { }
extension OtherView: Inspectable { }

final class MyViewTests: XCTestCase {
    
    // HStackに含まれるViewの中身のテスト
    func testStringValue() throws {
        let myView = MyView()
        let value = try myView.inspect().hStack().anyView(1).view(OtherView.self).text().string()
        XCTAssertEqual(value, "Ok")
    }
    
}

