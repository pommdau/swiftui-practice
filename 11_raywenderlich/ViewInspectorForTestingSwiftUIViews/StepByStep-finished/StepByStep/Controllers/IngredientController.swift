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

import Foundation
import CoreData
import SwiftUI

class IngredientController: NSObject, ObservableObject {
  @Published private(set) var ingredients: [Ingredient] = []
  @Published var selectedIngredient: Ingredient?
  @ObservedObject private var recipe: Recipe
  private var dataStack: CoreDataStack

  init(recipe: Recipe, dataStack: CoreDataStack) {
    self.dataStack = dataStack
    self.recipe = recipe
    super.init()
    ingredients = recipe.orderedIngredients
  }
}

extension IngredientController {
  func deleteIngredients(atOffsets: IndexSet) {
    for index in atOffsets {
      let ingredient = ingredients[index]
      if ingredient == selectedIngredient {
        selectedIngredient = nil
      }
      dataStack.viewContext.delete(ingredient)
    }
    ingredients = recipe.orderedIngredients
  }

  func moveIngredients(fromOffsets: IndexSet, toOffset: Int) {
    ingredients.move(fromOffsets: fromOffsets, toOffset: toOffset)
    assertOrderingIndex()
  }

  func assertOrderingIndex() {
    for (index, ingredient) in ingredients.enumerated()
    where ingredient.orderingIndex != Int16(index) {
      ingredient.orderingIndex = Int16(index)
    }
  }
}

extension IngredientController {
  @discardableResult
  func createIngredient() -> Ingredient {
    let newIngredient = Ingredient(context: dataStack.viewContext)
    recipe.addToIngredients(newIngredient)
    ingredients.append(newIngredient)
    assertOrderingIndex()
    return newIngredient
  }

  func insertIngredient(_ ingredient: Ingredient, at index: Int) {
    ingredient.orderingIndex = Int16(index)
    assertOrderingIndex()
  }
}
