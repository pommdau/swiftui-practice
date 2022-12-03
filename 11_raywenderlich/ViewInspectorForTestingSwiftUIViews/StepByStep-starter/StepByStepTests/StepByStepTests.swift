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

  
}
