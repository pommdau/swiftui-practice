//
//  CustomViewModifierViewTests.swift
//  ViewInspectorDemoTests
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class CustomViewModifierViewTests: XCTestCase {
    
    func testCustomViewModifierAppliedToHierarchy() throws {
        let sut = EmptyView().modifier(MyViewModifier())
        let modifier = try sut.inspect().emptyView().modifier(MyViewModifier.self)
        let content = try modifier.viewModifierContent()
        XCTAssertTrue(content.hasPadding(.top))
        XCTAssertEqual(try content.padding(.top), 15)
    }
    
    // MARK: - Approach #1:
    
    func testViewModifier() {
        var sut = MyViewModifier2()
        let exp = sut.on(\.didAppear) { modifier in
            XCTAssertEqual(try modifier.viewModifierContent().padding(.top), 15)
        }
        
        let view = EmptyView().modifier(sut)
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.1)
    }
    
    // MARK: - Approach #2:
    
    func testViewModifier2() {
        let sut = MyViewModifier3()
        let exp = sut.inspection.inspect(after: 0.1) { modifier in
            XCTAssertEqual(try modifier.viewModifierContent().padding(.top), 15)
        }
        let view = EmptyView().modifier(sut)
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.2)
    }
}
