//
//  GestureMaskViewTests.swift
//  GuideGesturesTests
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class GestureMaskViewTests: XCTestCase {
    
    // [GestureMask](https://developer.apple.com/documentation/swiftui/gesturemask)
    func testGestureMaskView1() throws {
        let sut = GestureMaskView1()
        let gesture = try sut.inspect().shape(0).gesture(TapGesture.self)
        XCTAssertEqual(try gesture.gestureMask(), .gesture)
    }
        
}
