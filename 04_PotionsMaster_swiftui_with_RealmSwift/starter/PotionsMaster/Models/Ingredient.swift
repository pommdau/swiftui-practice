

struct Ingredient: Identifiable {
  let id: Int
  let title: String
  let notes: String
  let bought: Bool
  var colorName = "rw-green"
  let quantity: Int
}

// MARK: Convenience init
extension Ingredient {
  init(ingredientDB: IngredientDB) {
    id = ingredientDB.id
    title = ingredientDB.title
    notes = ingredientDB.notes
    bought = ingredientDB.bought
    colorName = ingredientDB.colorName
    quantity = ingredientDB.quantity
  }
}
