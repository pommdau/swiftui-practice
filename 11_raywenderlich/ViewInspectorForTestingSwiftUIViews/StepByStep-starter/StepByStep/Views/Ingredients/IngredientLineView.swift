/// Copyright (c) 2021 Razeware LLC
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
import SwiftUI

struct IngredientLineView: View {
  @ObservedObject var ingredient: Ingredient

  var fontColor: Color {
    return .black
  }

  var body: some View {
    HStack {
      HStack(spacing: 8) {
        Text(ingredient.name ?? AppStrings.defaultTitle)
          .fontWeight(.bold)
          .font(.caption)
          .foregroundColor(fontColor)
        Text(ingredient.longDescription ?? AppStrings.defaultDescription)
          .font(.caption)
          .foregroundColor(fontColor)
          .lineLimit(3)
        Spacer()
      }
    }
  }
}

struct IngredientLineView_Previews: PreviewProvider {
  static let controller = RecipeController.previewController()
  static let recipe: Recipe = {
    return controller.createRecipe()
  }()
  static let ingredient: Ingredient = {
    let ingredient = controller.createIngredient(for: recipe)
    ingredient.name = "Flour"
    ingredient.longDescription = "250g plain flour"
    ingredient.orderingIndex = 99
    return ingredient
  }()

  static var previews: some View {
    return Group {
      IngredientLineView(ingredient: ingredient)
    }
  }
}
