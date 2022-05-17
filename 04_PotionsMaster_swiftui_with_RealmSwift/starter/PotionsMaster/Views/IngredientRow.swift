import SwiftUI

struct IngredientRow: View {
  @EnvironmentObject var store: IngredientStore
  @State private var ingredientFormIsPresented = false
  let ingredient: Ingredient

  var body: some View {
    HStack {
      Button(action: openUpdateIngredient) {
        Text("\(ingredient.quantity)")
          .bold()
          .padding(.horizontal, 4)
        VStack(alignment: .leading) {
          Text(ingredient.title)
            .font(.headline)
          Text(ingredient.notes)
            .font(.subheadline)
            .lineLimit(1)
        }
      }
      .buttonStyle(PlainButtonStyle())
      .sheet(isPresented: $ingredientFormIsPresented) {
        IngredientFormView(form: IngredientForm(self.ingredient))
          .environmentObject(self.store)
      }
      Spacer()
      // TODO: Insert Circle view here
      Circle()
        .fill(Color(ingredient.colorName))
        .frame(width: 12, height: 12)
      Button(action: buyOrDeleteIngredient) {
        Image(systemName: ingredient.bought ? "trash.circle.fill" : "circle")
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(ingredient.bought ? .red : .gray)
      }
    }
  }
}

// MARK: - Actions
extension IngredientRow {
  func openUpdateIngredient() {
    if !ingredient.bought {
      ingredientFormIsPresented.toggle()
    }
  }

  func buyOrDeleteIngredient() {
    withAnimation {
      if ingredient.bought {
        store.delete(ingredientID: ingredient.id)
      } else {
        store.toggleBought(ingredient: ingredient)
      }
    }
  }
}

#if DEBUG
struct IngredientRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      IngredientRow(ingredient: IngredientMock.ingredientsMock[0])
      IngredientRow(ingredient: IngredientMock.boughtIngredientsMock[0])
    }
    .previewLayout(.sizeThatFits)
  }
}
#endif
