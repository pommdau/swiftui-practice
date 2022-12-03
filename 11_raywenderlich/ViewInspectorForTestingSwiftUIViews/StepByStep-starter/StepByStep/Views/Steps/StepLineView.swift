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

struct StepLineView: View {
  @ObservedObject var step: Step

  var fontColor: Color {
    return .black
  }

  var body: some View {
    HStack {
      Circle()
        .fill(Color.gray)
        .overlay(
          Text("\(step.orderingIndex + 1)")
            .font(.largeTitle)
            .fontWeight(.medium)
        )
        .frame(width: 50)
      VStack(alignment: .leading, spacing: 8) {
        Text(step.name ?? "No name")
          .fontWeight(.bold)
          .font(.caption)
          .foregroundColor(fontColor)
        Text(step.longDescription ?? "No description")
          .conditionallyItalic(step.longDescription == nil)
          .font(.caption)
          .foregroundColor(fontColor)
          .lineLimit(3)
      }
    }
    .padding(4)
  }
}

struct StepLineView_Previews: PreviewProvider {
  static var previews: some View {
    let controller = RecipeController.previewController()
    let recipe: Recipe = controller.createRecipe()

    let step1 = controller.createStep(for: recipe)
    step1.name = "Hello"
    step1.longDescription = "World"
    step1.orderingIndex = 1

    let step2 = controller.createStep(for: recipe)

    return VStack {
      StepLineView(step: step1)
      StepLineView(step: step2)
    }
  }
}
