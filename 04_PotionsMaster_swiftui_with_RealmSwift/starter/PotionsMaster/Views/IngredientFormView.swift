

import SwiftUI

struct IngredientFormView: View {
  @EnvironmentObject var store: IngredientStore
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var form: IngredientForm
  let quantityOptions = [1, 2, 3, 4, 5]
  let colorOptions = ColorOptions.allCases

  var body: some View {
    NavigationView {
      Form {
        TextField("Title", text: $form.title)
        Picker(selection: $form.quantity, label: Text("Quantity")) {
          ForEach(quantityOptions, id: \.self) { option in
            Text("\(option)")
              .tag(option)
          }
        }
        
        // TODO: Insert Picker here
        Picker(selection: $form.color, label: Text("Color")) {
          ForEach(colorOptions, id: \.self) { option in
            Text(option.title)
          }
        }        
        
        Section(header: Text("Notes📝")) {
          TextField("", text: $form.notes)
        }
      }
      .navigationBarTitle("Ingredient Form", displayMode: .inline)
      .navigationBarItems(
        leading: Button("Cancel", action: dismiss),
        trailing: Button(
          form.updating ? "Update" : "Save",
          action: form.updating ? updateIngredient : saveIngredient))
    }
  }
}

// MARK: - Actions
extension IngredientFormView {
  func dismiss() {
    presentationMode.wrappedValue.dismiss()
  }

  func saveIngredient() {
    store.create(
      title: form.title,
      notes: form.notes,
      quantity: form.quantity,
      colorName: form.color.name
    )
    dismiss()
  }

  func updateIngredient() {
    if let ingredientID = form.ingredientID {
      store.update(
        ingredientID: ingredientID,
        title: form.title,
        notes: form.notes,
        quantity: form.quantity,
        colorName: form.color.name
      )
      dismiss()
    }
  }
}

#if DEBUG
struct IngredientFormView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      IngredientFormView(form: IngredientForm())
      IngredientFormView(form: IngredientForm(IngredientMock.ingredientsMock[0]))
    }
  }
}
#endif
