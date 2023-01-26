//
//  AlertViewTests.swift
//  GuidePopupTests
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//

import XCTest
import SwiftUI
@testable import ViewInspectorDemo
import ViewInspector

final class AlertViewTests: XCTestCase {
    
    func testAlertExample() throws {
        let binding = Binding(wrappedValue: true)
        let sut = EmptyView().alert2(isPresented: binding) {
            Alert(title: Text("Title"), message: Text("Message"),
                  primaryButton: .destructive(Text("Delete")),
                  secondaryButton: .cancel(Text("Cancel")))
        }
        let alert = try sut.inspect().emptyView().alert()
        XCTAssertEqual(try alert.title().string(), "Title")
        XCTAssertEqual(try alert.message().text().string(), "Message")
        XCTAssertEqual(try alert.primaryButton().style(), .destructive)
        try sut.inspect().find(ViewType.AlertButton.self, containing: "Cancel").tap()
    }
    
    func testAlertView1() throws {
        let sut = AlertView1()
        let exp = sut.inspection.inspect { view in
            XCTAssertFalse(try view.actualView().isShowingAlert)
            try view.find(button: "Toggle").tap()
            XCTAssertTrue(try view.actualView().isShowingAlert)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    func testAlertView1AndCheckAlert() throws {

        let sut = AlertView1()
        let exp = sut.inspection.inspect { view in
            XCTAssertFalse(try view.actualView().isShowingAlert)
            try view.find(button: "Toggle").tap()
            XCTAssertTrue(try view.actualView().isShowingAlert)
            
            let alert = try view.vStack().alert()
            XCTAssertEqual(try alert.title().string(), "Title")
            XCTAssertEqual(try alert.message().text().string(), "Message")
            XCTAssertEqual(try alert.primaryButton().style(), .destructive)
            try view.find(ViewType.AlertButton.self, containing: "Cancel").tap()

        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
    
    // MARK: - Over iOS15
    
    func testAlertView2() throws {
        let sut = AlertView2()
        let exp = sut.inspection.inspect { view in
            XCTAssertFalse(try view.actualView().isShowingAlert)
            try view.find(button: "Toggle").tap()
            XCTAssertTrue(try view.actualView().isShowingAlert)
            
            let alert = try view.vStack().alert()
            XCTAssertEqual(try alert.title().string(), "Title")
            XCTAssertEqual(try alert.message().text().string(), "Message")
            XCTAssertEqual(try view.find(ViewType.Button.self, containing: "Cancel").role(), .cancel)
            XCTAssertEqual(try view.find(ViewType.Button.self, containing: "Remove").role(), .destructive)
            try view.find(ViewType.Button.self, containing: "Cancel").tap()

        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
}
