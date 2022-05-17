/// Copyright (c) 2020 Razeware LLC
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
import RealmSwift

final class IngredientStore: ObservableObject {
  private var ingredientResults: Results<IngredientDB>
  private var boughtIngredientResults: Results<IngredientDB>

  init(realm: Realm) {
    ingredientResults = realm.objects(IngredientDB.self)
      .filter("bought = false")
    boughtIngredientResults = realm.objects(IngredientDB.self)
      .filter("bought = true")
  }

  var ingredients: [Ingredient] {
    ingredientResults.map(Ingredient.init)
  }

  var boughtIngredients: [Ingredient] {
    boughtIngredientResults.map(Ingredient.init)
  }
}

// MARK: - CRUD Actions
extension IngredientStore {
  func create(title: String, notes: String, quantity: Int, colorName: String) {
    objectWillChange.send()

    do {
      let realm = try Realm()

      let ingredientDB = IngredientDB()
      ingredientDB.id = UUID().hashValue
      ingredientDB.title = title
      ingredientDB.notes = notes
      ingredientDB.quantity = quantity
      ingredientDB.colorName = colorName

      try realm.write {
        realm.add(ingredientDB)
      }
    } catch let error {
      // Handle error
      print(error.localizedDescription)
    }
  }

  func toggleBought(ingredient: Ingredient) {
    objectWillChange.send()
    do {
      let realm = try Realm()
      try realm.write {
        realm.create(
          IngredientDB.self,
          value: ["id": ingredient.id, "bought": !ingredient.bought],
          update: .modified)
      }
    } catch let error {
      // Handle error
      print(error.localizedDescription)
    }
  }

  func update(
    ingredientID: Int,
    title: String,
    notes: String,
    quantity: Int,
    colorName: String
  ) {
    objectWillChange.send()
    do {
      let realm = try Realm()
      try realm.write {
        realm.create(
          IngredientDB.self,
          value: [
            "id": ingredientID,
            "title": title,
            "notes": notes,
            "quantity": quantity,
            "colorName": colorName
          ],
          update: .modified)
      }
    } catch let error {
      // Handle error
      print(error.localizedDescription)
    }
  }

  func delete(ingredientID: Int) {
    // 1
    objectWillChange.send()
    // 2
    guard let ingredientDB = boughtIngredientResults.first(
      where: { $0.id == ingredientID })
      else { return }

    do {
      let realm = try Realm()
      try realm.write {
        realm.delete(ingredientDB)
      }
    } catch let error {
      // Handle error
      print(error.localizedDescription)
    }
  }
}
