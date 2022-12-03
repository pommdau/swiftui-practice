/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
import SwiftUI
import ViewInspector
@testable import StepByStep

class StepByStepTests: XCTestCase {
  func testViewInspectorBaseline() throws {
    let expected = "it lives!"
    let sut = Text(expected)
    let value = try sut.inspect().text().string()
    XCTAssertEqual(value, expected)
  }

  func testRecipeDefaultText() throws {
    let controller = RecipeController.previewController()
    let recipe = controller.createRecipe()
    let view = RecipeLineView(recipe: recipe)
    let inspectedName = try view
      .inspect()
      .find(text: AppStrings.defaultTitle)
      .string()
    XCTAssertEqual(AppStrings.defaultTitle, inspectedName)
    let inspectedDescription = try view
      .inspect()
      .find(text: AppStrings.defaultDescription)
      .string()
    XCTAssertEqual(AppStrings.defaultDescription, inspectedDescription)
  }

  func testRecipeNameStyle() throws {
    let controller = RecipeController.previewController()
    let recipe = controller.createRecipe()
    let view = RecipeLineView(recipe: recipe)
    let inspectedName = try view.inspect().find(text: AppStrings.defaultTitle)
    let fontStyle = try inspectedName.attributes().font().style()
    XCTAssertEqual(fontStyle, .title2)
    let fontWeight = try inspectedName.attributes().fontWeight()
    XCTAssertEqual(fontWeight, .medium)
  }

  func testAddRecipeAddsRecipe() throws {
    let controller = RecipeController.previewController()
    let view = RecipeListView()
    // 1
    let expectation = view.inspection.inspect { view in
      XCTAssertEqual(controller.recipes.count, 0)
      try view.find(button: "Add Recipe").tap()
      XCTAssertEqual(controller.recipes.count, 1)
    }
    // 2
    ViewHosting.host(view: view.environmentObject(controller))
    // 3
    self.wait(for: [expectation], timeout: 1.0)
  }

  func testAddRecipeButtonHasCorrectStyle() throws {
    let controller = RecipeController.previewController()
    let view = RecipeListView()
    let expectation = view.inspection.inspect { view in
      let button = try view.find(button: "Add Recipe")
      XCTAssertTrue(try button.buttonStyle() is AdditiveButtonStyle)
    }
    ViewHosting.host(view: view.environmentObject(controller))
    self.wait(for: [expectation], timeout: 1.0)
  }

  func testAdditiveButtonStylePressedState() throws {
    let style = AdditiveButtonStyle()
    XCTAssertEqual(try style.inspect(isPressed: true).scaleEffect().width, 1.1)
    XCTAssertEqual(try style.inspect(isPressed: false).scaleEffect().width, 1.0)
  }

  func testStepName(_ index: Int) -> String {
    "Step -\(index)"
  }

  func makeStepController(_ count: Int) -> StepController {
    let recipeController = RecipeController.previewController()
    let recipe = recipeController.createRecipe()
    for idx in 1...count {
      let step = recipeController.createStep(for: recipe)
      step.name = testStepName(idx)
      step.orderingIndex = Int16(idx)
    }

    let stepController = StepController(recipe: recipe, dataStack: recipeController.dataStack)
    return stepController
  }

  func testStepListCellCountSmall() throws {
    let expectedCount = 20
    let stepController = makeStepController(expectedCount)
    let view = StepListView(stepController: stepController)

    let expectation = view.inspection.inspect { view in
      let cells = view.findAll(StepLineView.self)
      XCTAssertEqual(cells.count, expectedCount)
    }
    ViewHosting.host(view: view)
    self.wait(for: [expectation], timeout: 1.0)
  }

  func testStepListCellContent() throws {
    let expectedCount = 10
    let stepController = makeStepController(expectedCount)
    let view = StepListView(stepController: stepController)

    let expectation = view.inspection.inspect { view in
      for idx in 1...expectedCount {
        _ = try view.find(StepLineView.self, containing: self.testStepName(idx))
      }
    }
    ViewHosting.host(view: view)
    self.wait(for: [expectation], timeout: 1.0)
  }

  func testStepCellNavigationLink() throws {
    let expectedCount = 1
    let stepController = makeStepController(expectedCount)
    let view = StepListView(stepController: stepController)

    let expectation = view.inspection.inspect { view in
      let navLink = try view.find(ViewType.NavigationLink.self)
      _ = try navLink.view(StepEditorView.self)
    }
    ViewHosting.host(view: view)
    self.wait(for: [expectation], timeout: 1.0)
  }
}
