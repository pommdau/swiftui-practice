//
//  InvokingGestureUpdatingCallbackViewTests.swift
//  GuideGesturesTests
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class InvokingGestureUpdatingCallbackViewTests: XCTestCase {

    func testTestGestureUpdating() throws {
        let sut = InvokingGestureUpdatingCallbackView()
        let exp1 = sut.inspection.inspect { view in
            XCTAssertEqual(try view.actualView().isDetectingLongPress, false)
            XCTAssertEqual(try view.shape(0).fillShapeStyle(Color.self), Color.green)
            let gesture = try view.shape(0).gesture(LongPressGesture.self)
            let value = LongPressGesture.Value(finished: true)
            var state: Bool = false
            var transaction = Transaction()
            try gesture.callUpdating(value: value, state: &state, transaction: &transaction)
            sut.publisher.send()
        }

        let exp2 = sut.inspection.inspect(onReceive: sut.publisher) { view in
            XCTAssertEqual(try view.shape(0).fillShapeStyle(Color.self), Color.green)
        }

        ViewHosting.host(view: sut)
        wait(for: [exp1, exp2], timeout: 0.1)
    }
    
}
