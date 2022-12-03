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

import SwiftUI

struct RecipeEditorView: View {
  @EnvironmentObject var recipeController: RecipeController
  @ObservedObject var recipe: Recipe

  @State var recipeName: String = ""
  @State var recipeDescription: String = ""

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
          Text("Name")
            .fontWeight(.medium)
            .font(.subheadline)
          TextField("Name", text: $recipeName, prompt: Text("Recipe name"))
            .padding(4)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.secondary, lineWidth: 1))
        }
        VStack(alignment: .leading, spacing: 8) {
          Text("Description")
            .fontWeight(.medium)
            .font(.subheadline)
          TextEditor(text: $recipeDescription)
            .frame(height: 100)
            .background(Color.gray)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.secondary, lineWidth: 1))
        }
        Divider()
        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text("Ingredients")
              .fontWeight(.medium)
              .font(.subheadline)
            Spacer()
            NavigationLink(
              "Edit Ingredients",
              destination: IngredientListView(
                ingredientController: IngredientController(
                  recipe: recipe,
                  dataStack: recipeController.dataStack
                )
              )
            )
          }
          ForEach(recipe.orderedIngredients, id: \.self) { ingredient in
            IngredientLineView(ingredient: ingredient)
          }
        }
        Divider()
        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Text("Steps")
              .fontWeight(.medium)
              .font(.subheadline)
            Spacer()
            NavigationLink(
              "Edit Steps",
              destination: StepListView(
                stepController: StepController(
                  recipe: recipe,
                  dataStack: recipeController.dataStack
                )
              )
            )
          }
          ForEach(recipe.orderedSteps, id: \.self) { step in
            StepLineView(step: step)
          }
        }
        Spacer()
      }
      .navigationTitle("Recipe")
      .padding()
      .onAppear {
        recipeName = recipe.name ?? ""
        recipeDescription = recipe.longDescription ?? ""
      }
      .onChange(of: recipeName) { newValue in
        recipe.name = newValue
      }
      .onChange(of: recipeDescription) { newValue in
        recipe.longDescription = newValue
      }
    }
  }
}

struct EditorView_Previews: PreviewProvider {
  static let controller = RecipeController.previewController()
  static let recipe: Recipe = {
    let recipe = controller.createRecipe()
    recipe.name = "Pancakes"
    recipe.longDescription = "Tasty any time of day"
    return recipe
  }()

  static var previews: some View {
    return RecipeEditorView(recipe: recipe)
      .environmentObject(controller)
  }
}
