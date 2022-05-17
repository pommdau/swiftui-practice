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

enum IngredientMock {
  static let unicornTailHair = Ingredient(
    id: 0,
    title: "Unicorn Tail Hair",
    notes: "Used in Beautification Potion",
    bought: false,
    quantity: 1)

  static let dittany = Ingredient(
    id: 1,
    title: "Dittany",
    notes: "Used in healing potions like Wiggenweld",
    bought: false,
    quantity: 1)

  static let mandrake = Ingredient(
    id: 2,
    title: "Mandrake",
    notes: "Used in a healing potion called the Mandrake Restorative Draught",
    bought: false,
    quantity: 1)

  static let aconite = Ingredient(
    id: 3,
    title: "aconite",
    notes: "Used in the Wolfsbane Potion",
    bought: false,
    quantity: 1)

  static let unicornBlood = Ingredient(
    id: 4,
    title: "Unicorn blood",
    notes: "Used in Rudimentary body potions",
    bought: false,
    quantity: 1)

  static let ingredientsMock = [
    unicornTailHair,
    dittany,
    mandrake,
    aconite,
    unicornBlood
  ]

  static let roseThorn = Ingredient(
    id: 5,
    title: "Rose Thorn",
    notes: "Used in Love potions",
    bought: true,
    quantity: 2)

  static let rosePetals = Ingredient(
    id: 5,
    title: "Rose Petals",
    notes: "Used in Love potions",
    bought: true,
    quantity: 2)

  static let boughtIngredientsMock = [
    roseThorn,
    rosePetals
  ]
}
