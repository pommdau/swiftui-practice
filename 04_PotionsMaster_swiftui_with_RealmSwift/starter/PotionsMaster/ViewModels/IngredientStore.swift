import Foundation
import RealmSwift

final class IngredientStore: ObservableObject {
  //  var ingredients: [Ingredient] = IngredientMock.ingredientsMock
  //  var boughtIngredients: [Ingredient] = IngredientMock.boughtIngredientsMock
  private var ingredientResults: Results<IngredientDB>
  private var boughtIngredientResults: Results<IngredientDB>
  
  var ingredients: [Ingredient] {
    ingredientResults.map(Ingredient.init)
  }
  
  var boughtIngredients: [Ingredient] {
    boughtIngredientResults.map(Ingredient.init)
  }
  
  init(realm: Realm) {
    ingredientResults = realm.objects(IngredientDB.self)
      .filter("bought = false")
    boughtIngredientResults = realm.objects(IngredientDB.self)
      .filter("bought = true")
  }
  
}

// MARK: - CRUD Actions
extension IngredientStore {
  func create(title: String, notes: String, quantity: Int, colorName: String) {
    // TODO: Add Realm create code below
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
    // TODO: Add Realm update code below
    
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
    
    // TODO: Add Realm update code below
    
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
            "quantity": quantity
          ],
          update: .modified)
      }
    } catch let error {
      // Handle error
      print(error.localizedDescription)
    }
    
    
  }
  
  func delete(ingredientID: Int) {
    // TODO: Add Realm delete code below
    
    objectWillChange.send()
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
