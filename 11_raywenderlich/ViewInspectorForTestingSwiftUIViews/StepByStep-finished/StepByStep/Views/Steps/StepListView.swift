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

struct StepListView: View {
  @StateObject var stepController: StepController
  internal let inspection = Inspection<Self>()

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Button("Add Step") {
          let newStep = stepController.createStep()
          stepController.insertStep(newStep, at: 0)
          stepController.selectedStep = newStep
        }
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
