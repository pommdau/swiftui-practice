//
//  ViewInspectorTests.swift
//  ViewInspectorTests
//
//  Created by HIROKI IKEUCHI on 2022/12/23.
//
//  ref: [ViewInspector/guide\.md](https://github.com/nalexn/ViewInspector/blob/master/guide.md#the-basics)

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

// MARK: - The Basics

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
        let view = MyView()
        let value = try view.inspect().hStack().anyView(1).view(OtherView.self).text().string()
        XCTAssertEqual(value, "Ok")
    }
    
    // 途中経過を保存する書き方
    func testStringValueWithIntermediateResult() throws {
        let view = MyView()
        let hStack = try view.inspect().hStack()
        let hiText = try hStack.text(0)  // Text()の取得
        let okText = try hStack.anyView(1).view(OtherView.self).text()
        
        XCTAssertEqual(try hiText.string(), "Hi")
        XCTAssertEqual(try okText.string(), "Ok")
    }
}

// MARK: - Dynamic query with find

// find: 幅優先探索でビューを検索。見つからなかった場合に例外エラー
// findAll: 見つからなかった場合に空の配列

extension MyView2: Inspectable { }

final class MyView2Tests: XCTestCase {
    
    // HStackに含まれるViewの中身のテスト
    func testStringValue() throws {
        let view = MyView2()
        
        XCTAssertEqual(try view.inspect().vStack().find(ViewType.HStack.self).text(1).string(),
                       "text2")

        XCTAssertEqual(try view.inspect().find(text: "text1").string(),
                       "text1")
        
        // Buttonのテキストを取得
        let button1Title = "button1"
        let button1 = try view.inspect().find(button: button1Title)
        XCTAssertEqual(try button1.find(ViewType.Text.self).string(),
                       button1Title)
        
        // where condition
        XCTAssertEqual(try view.inspect().find(ViewType.Text.self, where: { try $0.string() == "text1" }).string(),
                       "text1")
        
        // pathToRoot
        let text1 = try view.inspect().find(text: "text1")
        print(text1.pathToRoot)  // view(MyView2.self).vStack().hStack(0).text(0)
    }
    
    func testParent() throws {
        // parent
        let myView2 = MyView2()
        let anyView = AnyView(HStack { Text("text1") })
        let text1 = try myView2.inspect().find(text: "text1")
        let hStack = try text1.parent().hStack()
        let text2 = try hStack.text(1)
        XCTAssertEqual(try text2.string(),
                       "text2")

        // 二階層遡る
        let button1  = try text1.parent().parent().find(button: "button1")
        XCTAssertEqual(try button1.find(text: "button1").string(),
                       "button1")

        // text1から見て親の方向を探す(HStack, VStackが見つかる)
        // VStackに遡ってPlayButtonを見つけてみる
        let vStack = try text1.find(ViewType.VStack.self, relation: .parent)
        let playButtonTitle = "PlayButton"
        let playButton = try vStack.find(button: playButtonTitle)
        XCTAssertEqual(try playButton.find(ViewType.Text.self).string(),
                       playButtonTitle)
    }
}

