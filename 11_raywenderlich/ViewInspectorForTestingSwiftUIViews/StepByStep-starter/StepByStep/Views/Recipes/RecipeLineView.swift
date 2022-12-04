import SwiftUI

struct RecipeLineView: View {
  @ObservedObject var recipe: Recipe

  var fontColor: Color {
    return .black
  }

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(recipe.name ?? AppStrings.defaultTitle)
          .fontWeight(.medium)
          .font(.title2)
          .foregroundColor(.primary)
        Text(recipe.longDescription ?? AppStrings.defaultDescription)
          .font(.caption)
          .foregroundColor(.primary)
          .lineLimit(3)
      }
    }
  }
}

struct RecipeLineView_Previews: PreviewProvider {
  static var previews: some View {
    let controller = RecipeController.previewController()
    let recipe = controller.createRecipe()
    recipe.name = "Pancakes"
    // swiftlint:disable:next line_length
    recipe.longDescription = "Sweet pancakes that work anytime of the day. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lorem elit, ullamcorper dictum mollis quis, tincidunt eu sapien. Integer semper leo ex, eu placerat mi ultricies ut. Nulla dui purus, imperdiet tempus ante id, maximus porta tortor."
    return Group {
      RecipeLineView(recipe: recipe)
    }
    .padding()
  }
}
