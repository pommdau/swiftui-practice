//
//  DynamicQueryWithFindViewTests.swift
//  ViewInspectorDemoTests
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class DynamicQueryWithFindViewTests: XCTestCase {
    
    // MARK: - DynamicQueryWithFindView1
    
    func testDynamicQueryWithFindView1() throws {
        let sut = DynamicQueryWithFindView1()
        let okText = try sut.inspect().find(ViewType.HStack.self).text(1)  // find
        let _ = try sut.inspect().find(text: "Ok")  // okTextと同義
        XCTAssertEqual(try okText.string(), "Ok")
        
        let textsInHStack = try sut.inspect().findAll(ViewType.Text.self)
        XCTAssertEqual(try textsInHStack[0].string(), "Hi")
        XCTAssertEqual(try textsInHStack[1].string(), "Ok")
        
        // findの機能の例
        let xyzText = try sut.inspect().find(text: "xyz")
        let xyzButton = try sut.inspect().find(button: "xyz")
        let viewWithId = try sut.inspect().find(viewWithId: 7)
        let viewWithTag = try sut.inspect().find(viewWithTag: "Home")
        let hStack = try sut.inspect().find(ViewType.HStack.self)
        let playButton01 = try sut.inspect().find(viewWithAccessibilityLabel: "Play button")
        let playButton02 = try sut.inspect().find(viewWithAccessibilityIdentifier: "play_button")
        
        XCTAssertEqual(try xyzText.string(), "xyz")
        XCTAssertEqual(try xyzButton.find(text: "xyz").string(), "xyz")
        XCTAssertEqual(try viewWithId.find(ViewType.Text.self).string(), "viewWithId: 7")
        XCTAssertEqual(try viewWithTag.find(ViewType.Text.self).string(), "viewWithTag: Home")
        XCTAssertEqual(hStack.count, 2)
        XCTAssertEqual(try playButton01.find(ViewType.Text.self).string(), "Play")
        XCTAssertEqual(try playButton02.find(ViewType.Text.self).string(), "Play")
        
        // MARK: where condition
        
        let okText02 = try sut.inspect().find(ViewType.Text.self, where: { try $0.string() == "Ok" })
        XCTAssertEqual(try okText02.string(), "Ok")
        
        // MARK: pathToRoot
        
        //        print(xyzText.pathToRoot)
        //        view(DynamicQueryWithFindView1.self).vStack().button(1).labelView().text()
    }
    
    // MARK: - DynamicQueryWithFindView2
    
    func testDynamicQueryWithFindView2() throws {

        // MARK: parent
        
        let sut = DynamicQueryWithFindView2()
        let text = try sut.inspect().find(text: "abc")
        let _ = try text.parent().hStack()  // HStack
        let _ = try text.parent().parent().vStack()  // VStack
        
        let _ = try text.find(ViewType.HStack.self, relation: .parent)  // HStack
        
        let title = try sut.inspect().find(text: "title1")
        let _ = try title.find(TableViewCell.self, relation: .parent)  // find cell
        let _ = try sut.inspect().find(TableViewCell.self, containing: "title1")  // find cell
        
        // MARK: Generic find function
        
        // 2つ目のText("abc")を取得
        let text2 = try sut.inspect()
            .find(relation: .child,
                  traversal: .breadthFirst,
                  skipFound: 1, where: { try $0.text().string() == "abc" })
            .text()
        XCTAssertEqual(try text2.string(), "abc")
        
        // MARK: Your custom find functions
        
        let headlineText = try sut.inspect().find(textWithFont: Font.headline)
        XCTAssertEqual(try headlineText.string(), "abc")
    }
}

extension InspectableView {
    func find(textWithFont font: Font) throws -> InspectableView<ViewType.Text> {
        return try find(ViewType.Text.self, where: {
            try $0.attributes().font() == font
        })
    }
}


