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

import Foundation
import CoreData
import SwiftUI

class StepController: NSObject, ObservableObject {
  @Published private(set) var steps: [Step] = []
  @Published var selectedStep: Step?
  @ObservedObject private var recipe: Recipe
  private var dataStack: CoreDataStack

  init(recipe: Recipe, dataStack: CoreDataStack) {
    self.dataStack = dataStack
    self.recipe = recipe
    super.init()
    steps = recipe.orderedSteps
  }
}

extension StepController {
  func deleteSteps(atOffsets: IndexSet) {
    for index in atOffsets {
      let step = steps[index]
      if step == selectedStep {
        selectedStep = nil
      }
      dataStack.viewContext.delete(step)
    }
    steps = recipe.orderedSteps
  }

  func moveSteps(fromOffsets: IndexSet, toOffset: Int) {
    steps.move(fromOffsets: fromOffsets, toOffset: toOffset)
    assertOrderingIndex()
  }

  func assertOrderingIndex() {
    for (index, step) in steps.enumerated()
    where step.orderingIndex != Int16(index) {
      step.orderingIndex = Int16(index)
    }
  }
}

extension StepController {
  @discardableResult
  func createStep() -> Step {
    let newStep = Step(context: dataStack.viewContext)
    recipe.addToSteps(newStep)
    steps.append(newStep)
    assertOrderingIndex()
    return newStep
  }

  func insertStep(_ step: Step, at index: Int) {
    step.orderingIndex = Int16(index)
    assertOrderingIndex()
  }
}
