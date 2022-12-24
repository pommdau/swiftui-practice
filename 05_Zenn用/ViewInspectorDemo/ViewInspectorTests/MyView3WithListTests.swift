//
//  MyView3WithListTests.swift
//  ViewInspectorTests
//
//  Created by HIROKI IKEUCHI on 2022/12/23.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import ViewInspectorDemo

extension MyView3WithList: Inspectable { }
extension MyView3WithListCell: Inspectable { }

final class MyView3WithListTests: XCTestCase {
    
    func testStringValue() throws {
        let sut = MyView3WithList()
        let title = try sut.inspect().find(text: "CellText")
    }
    
}
