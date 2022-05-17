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
