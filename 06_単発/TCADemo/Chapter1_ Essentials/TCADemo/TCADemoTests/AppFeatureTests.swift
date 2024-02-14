//
//  AppFeatureTests.swift
//  TCADemoTests
//
//  Created by HIROKI IKEUCHI on 2024/02/13.
//

@testable import TCADemo
import ComposableArchitecture
import XCTest


@MainActor
final class AppFeatureTests: XCTestCase {
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(.tab1(.incrementButtonTapped)) {
            $0.tab1.count = 1
        }
    }
    
    
}
