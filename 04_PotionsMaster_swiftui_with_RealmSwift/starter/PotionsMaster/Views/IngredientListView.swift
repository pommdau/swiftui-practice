import SwiftUI

struct IngredientListView: View {
  @EnvironmentObject var store: IngredientStore
  @State private var ingredientFormIsPresented = false
  let ingredients: [Ingredient]
  let boughtIngredients: [Ingredient]

  var body: some View {
    List {
      Section(header: Text("Ingredients")) {
        if ingredients.isEmpty {
          Text("Add some ingredients to the list🥬")
            .foregroundColor(.gray)
        }
        ForEach(ingredients) { ingredient in
          IngredientRow(ingredient: ingredient)
        }
        newIngredientButton
      }
      Section(header: Text("Bought")) {
        if boughtIngredients.isEmpty {
          Text("Buy some ingredients and list them here")
        }
        ForEach(boughtIngredients) { ingredient in
          IngredientRow(ingredient: ingredient)
        }
      }
    }
    .listStyle(GroupedListStyle())
    .navigationBarTitle("Potions Master🧪")
  }

  var newIngredientButton: some View {
    Button(action: openNewIngredient) {
      HStack {
        Image(systemName: "plus.circle.fill")
        Text("New Ingredient")
          .bold()
      }
    }
    .foregroundColor(.green)
    .sheet(isPresented: $ingredientFormIsPresented) {
      IngredientFormView(form: IngredientForm())
        .environmentObject(self.store)
    }
  }
}

// MARK: - Actions
extension IngredientListView {
  func openNewIngredient() {
    ingredientFormIsPresented.toggle()
  }
}

#if DEBUG
struct IngredientListView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      IngredientListView(
        ingredients: IngredientMock.ingredientsMock,
        boughtIngredients: IngredientMock.boughtIngredientsMock)
      IngredientListView(ingredients: [], boughtIngredients: [])
    }
  }
}
#endif
