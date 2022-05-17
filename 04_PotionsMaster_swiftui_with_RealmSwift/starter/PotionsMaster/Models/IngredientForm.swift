
import Foundation

class IngredientForm: ObservableObject {
  @Published var title = ""
  @Published var notes = ""
  @Published var quantity = 1
  @Published var color = ColorOptions.rayGreen
  var ingredientID: Int?

  var updating: Bool {
    ingredientID != nil
  }

  init() { }

  init(_ ingredient: Ingredient) {
    title = ingredient.title
    notes = ingredient.notes
    quantity = ingredient.quantity
    ingredientID = ingredient.id
    color = ColorOptions(rawValue: ingredient.colorName) ?? .rayGreen
  }
}
