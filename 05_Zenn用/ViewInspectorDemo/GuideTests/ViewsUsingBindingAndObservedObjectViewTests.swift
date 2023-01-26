//
//  ViewsUsingBindingAndObservedObjectViewTests.swift
//  ViewInspectorDemoTests
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class testViewsUsingBindingAndObservedObjectViewTests: XCTestCase {
    
    // MARK: - Views using @Binding
    // MARK: - Views using @ObservedObject
    
    func testInspectableAttributesView1() throws {
        let flag = Binding<Bool>(wrappedValue: false)
        let sut = ViewsUsingBindingAndObservedObjectView1(isOn: flag)

        XCTAssertFalse(flag.wrappedValue)
//        try sut.inspect().button().tap()  // うまく検出できないので下記で代用
        try sut.inspect().find(button: "Toggle status").tap()
        XCTAssertTrue(flag.wrappedValue)
    }
    
}
