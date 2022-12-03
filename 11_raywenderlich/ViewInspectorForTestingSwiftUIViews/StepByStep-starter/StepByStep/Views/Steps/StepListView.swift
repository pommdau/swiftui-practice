import SwiftUI

struct StepListView: View {
  internal let inspection = Inspection<Self>()
  @StateObject var stepController: StepController

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Button("Add Step") {
          let newStep = stepController.createStep()
          stepController.insertStep(newStep, at: 0)
          stepController.selectedStep = newStep
        }
        // add style here
        .buttonStyle(AdditiveButtonStyle())
      }
      List {
        ForEach(stepController.steps, id: \.self) { step in
          NavigationLink(
            destination: StepEditorView(step: step),
            tag: step,
            selection: $stepController.selectedStep) {
              StepLineView(step: step)
          }
        }
        .onDelete { indexset in
          stepController.deleteSteps(atOffsets: indexset)
        }
        .onMove { indexset, i in
          stepController.moveSteps(fromOffsets: indexset, toOffset: i)
        }
      }
      .listStyle(.plain)
      .toolbar {
        EditButton()
      }
      Spacer()
    }
    .padding()
    .navigationTitle("Steps")
    // add onReceive here
    .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
  }
}

struct StepListView_Previews: PreviewProvider {
  static var previews: some View {
    let controller = RecipeController.previewController()
    let recipe: Recipe = controller.createRecipe()

    let step1 = controller.createStep(for: recipe)
    step1.name = "Mix dry ingredients"
    step1.longDescription = "Mix flour, salt and baking powder in a large bowl"
    step1.orderingIndex = 1

    let step2 = controller.createStep(for: recipe)
    step2.name = "Mix wet ingredients"
    step2.longDescription = "Add milk and eggs to flour and mix till a smooth batter is achieved"
    step2.orderingIndex = 2

    let stepController = StepController(recipe: recipe, dataStack: controller.dataStack)

    return StepListView(stepController: stepController)
  }
}
