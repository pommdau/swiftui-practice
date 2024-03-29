import XCTest
import SwiftUI
import ViewInspector
@testable import StepByStep

final class StepByStepTests: XCTestCase {
  
  /*
   フレームワークが機能していることを検証するテストを行うことで、
   将来テストが壊れたときに時間を節約できます。
   このテストは、ブレークがフレームワークまたはコードのどちらにあるかという質問に答えます。
   */
  func testViewInspectorBaseline() throws {
    let expected = "it lives!"
    let sut = Text(expected)
    let value = try sut.inspect().text().string()
    XCTAssertEqual(value, expected)
  }
  
  func testRecipeDefaultText() throws {
    // 1: Create an empty recipe.
    let controller = RecipeController.previewController()
    let recipe = controller.createRecipe()
    let view = RecipeLineView(recipe: recipe)
    
    // 2: Verify the placeholder text matches the expected values in the UI.
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

    // 1: The name field should use title2 font.
    let fontStyle = try inspectedName.attributes().font().style()
    XCTAssertEqual(fontStyle, .title2)
    // 2: The name field should use medium font weight.
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
    /*
     ViewInspector supplies ViewHosting.
     ViewHosting provides a UIWindow and a UIHostingController
     大事-> for your view to live in while testing.
     */
    ViewHosting.host(view: view.environmentObject(controller))
    // 3
    self.wait(for: [expectation], timeout: 1.0)
  }
  
  // The first test checks that the button has AdditiveButtonStyle applied to it.
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

  // The second test verifies that AdditiveButtonStyle makes a button larger when pressed.
  func testAdditiveButtonStylePressedState() throws {
    let style = AdditiveButtonStyle()
    XCTAssertEqual(try style.inspect(isPressed: true).scaleEffect().width, 1.1)
    XCTAssertEqual(try style.inspect(isPressed: false).scaleEffect().width, 1.0)
  }
  
  // MARK: - Testing StepListView
  
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

    let stepController = StepController(
      recipe: recipe,
      dataStack: recipeController.dataStack
    )
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
