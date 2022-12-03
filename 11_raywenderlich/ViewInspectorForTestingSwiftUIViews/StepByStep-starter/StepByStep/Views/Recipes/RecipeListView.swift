import SwiftUI
import UniformTypeIdentifiers

struct RecipeListView: View {
  @EnvironmentObject var recipeController: RecipeController

  var body: some View {
    VStack {
      List {
        ForEach(recipeController.recipes, id: \.self) { recipe in
          NavigationLink(
            destination: RecipeEditorView(recipe: recipe),
            tag: recipe,
            selection: $recipeController.selectedRecipe) {
              RecipeLineView(recipe: recipe)
          }
        }
        .onDelete { indexset in
          recipeController.deleteRecipes(atOffsets: indexset)
        }
        .onMove { indexset, i in
          recipeController.moveRecipes(fromOffsets: indexset, toOffset: i)
        }
      }
      .toolbar {
        EditButton()
      }
      HStack {
        Button("Add Recipe") {
          let newRecipe = recipeController.createRecipe()
          recipeController.insertRecipe(newRecipe, at: 0)
          recipeController.selectedRecipe = newRecipe
        }
        // Add button style here
      }
      .padding(8)
    }
    // add onReceive here
  }
}

struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    let controller: RecipeController = {
      let controller = RecipeController.previewController()
      let recipe = controller.createRecipe()
      recipe.name = "Pancakes"
      recipe.longDescription = "Tasty any time of day"
      controller.createRecipe()
      return controller
    }()
    return RecipeListView()
      .environmentObject(controller)
  }
}
