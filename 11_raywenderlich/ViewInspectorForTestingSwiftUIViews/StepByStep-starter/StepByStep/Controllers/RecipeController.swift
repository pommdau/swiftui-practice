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
import Combine
import CoreData
import CoreSpotlight

class RecipeController: NSObject, ObservableObject {
  @Published private(set) var recipes: [Recipe] = []
  @Published var selectedRecipe: Recipe?
  private(set) var dataStack: CoreDataStack

  init(dataStack: CoreDataStack) {
    self.dataStack = dataStack
    super.init()
    recipes = fetchedResults.fetchedObjects ?? []
  }

  lazy var fetchedResults: NSFetchedResultsController<Recipe> = {
    let fetch = Recipe.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: "orderingIndex", ascending: true)
    fetch.sortDescriptors = [sortDescriptor]
    let controller = NSFetchedResultsController(
      fetchRequest: fetch,
      managedObjectContext: dataStack.viewContext,
      sectionNameKeyPath: nil,
      cacheName: "recipes")
    controller.delegate = self
    try? controller.performFetch()
    return controller
  }()

  static func previewController() -> RecipeController {
    RecipeController(dataStack: CoreDataStack(isPreview: true))
  }
}

extension RecipeController: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    recipes = fetchedResults.fetchedObjects ?? []
  }
}

extension RecipeController {
  func deleteRecipes(atOffsets: IndexSet) {
    for index in atOffsets {
      let recipe = recipes[index]
      if recipe == selectedRecipe {
        selectedRecipe = nil
      }
      dataStack.viewContext.delete(recipe)
    }
  }

  func moveRecipes(fromOffsets: IndexSet, toOffset: Int) {
    recipes.move(fromOffsets: fromOffsets, toOffset: toOffset)
    assertOrderingIndex()
  }

  func assertOrderingIndex() {
    for (index, recipe) in recipes.enumerated()
    where recipe.orderingIndex != Int16(index) {
      recipe.orderingIndex = Int16(index)
    }
  }
}

extension RecipeController {
  @discardableResult
  func createRecipe() -> Recipe {
    let newRecipe = Recipe(context: dataStack.viewContext)
    newRecipe.dateCreated = Date()
    recipes.append(newRecipe)
    assertOrderingIndex()
    return newRecipe
  }

  @discardableResult
  func createStep(for recipe: Recipe) -> Step {
    let newStep = Step(context: dataStack.viewContext)
    recipe.addToSteps(newStep)
    return newStep
  }

  @discardableResult
  func createIngredient(for recipe: Recipe) -> Ingredient {
    let newIngredient = Ingredient(context: dataStack.viewContext)
    recipe.addToIngredients(newIngredient)
    return newIngredient
  }

  func insertRecipe(_ recipe: Recipe, at index: Int) {
    recipe.orderingIndex = Int16(index)
    assertOrderingIndex()
  }
}
