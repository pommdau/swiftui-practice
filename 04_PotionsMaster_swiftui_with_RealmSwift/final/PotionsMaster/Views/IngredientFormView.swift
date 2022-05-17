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
      colorName: form.color.name)
    dismiss()
  }

  func updateIngredient() {
    if let ingredientID = form.ingredientID {
      store.update(
        ingredientID: ingredientID,
        title: form.title,
        notes: form.notes,
        quantity: form.quantity,
        colorName: form.color.name)
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
