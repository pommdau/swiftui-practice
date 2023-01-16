//
//  InspectableAttributesTests.swift.swift
//  ViewInspectorDemoTests
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class InspectableAttributesTests: XCTestCase {
    
    // MARK: - Inspectable attributes
    
    func testInspectableAttributesView1() throws {
        let sut = InspectableAttributesView1()
        let link = try sut.inspect().find(navigationLink: "Continue")  // Labelを指定
        let nextView = try link.view(MyView.self).actualView()  // linkからViewの取得
        XCTAssertEqual(nextView.parameter, "Screen 1")  // プロパティの確認
        
        let label = try link.labelView().text()
//        let label = try link.find(ViewType.Text.self).string()  // 同等の処理
        XCTAssertEqual(try label.string(), "Continue")
    }
}
