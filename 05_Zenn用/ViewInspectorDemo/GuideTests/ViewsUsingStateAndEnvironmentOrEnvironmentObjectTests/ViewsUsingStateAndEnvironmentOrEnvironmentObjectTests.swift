//
//  ViewsUsingStateAndEnvironmentOrEnvironmentObjectTests.swift
//  ViewInspectorDemoTests
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class ViewsUsingStateAndEnvironmentOrEnvironmentObjectTests: XCTestCase {
    
    // MARK: - Views using @State, @Environment or @EnvironmentObject
    
    func testButtonTogglesFlag() throws {
        let sut = ViewsUsingStateAndEnvironmentOrEnvironmentObjectView2()
        let exp = sut.inspection.inspect { view in
            XCTAssertFalse(try view.actualView().flag)
            try view.button().tap()
            XCTAssertTrue(try view.actualView().flag)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    func testButtonTogglesFlag2() throws {
        let sut = ViewsUsingStateAndEnvironmentOrEnvironmentObjectView2()
        // inspectを遅らせる
        let exp = sut.inspection.inspect(after: 0.1) { view in
            XCTAssertFalse(try view.actualView().flag)
            try view.button().tap()
            XCTAssertTrue(try view.actualView().flag)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 1.0)
    }
}
