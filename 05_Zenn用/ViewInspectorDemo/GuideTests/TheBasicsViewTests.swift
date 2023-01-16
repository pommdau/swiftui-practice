//
//  TheBasicsViewTests.swift
//  ViewInspectorDemoTests
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class TheBasicsViewTests: XCTestCase {

    // MARK: - TheBasicsView1
    
    func testTheBasicsView1() throws {
        let sut = TheBasicsView1()
        let value = try sut.inspect().text().string()
        XCTAssertEqual(value, "Hello, World!")
    }
    
    // MARK: - TheBasicsView2
    
    func testTheBasicsView2() throws {
        let view = TheBasicsView2()
        XCTAssertEqual(try view.inspect().hStack().anyView(1).view(OtherView.self).text().string(), "Ok")
        
        // 途中経過を保存できる
        let hStack = try view.inspect().hStack()
        let hiText = try hStack.text(0)
        let okText = try hStack.anyView(1).view(OtherView.self).text()
        XCTAssertEqual(try hiText.string(), "Hi")
        XCTAssertEqual(try okText.string(), "Ok")
    }
}
