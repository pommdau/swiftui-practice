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
import CoreData
import UIKit

class CoreDataStack: NSObject {
  private var container = NSPersistentContainer(name: "StepByStep")
  private var isPreviewContext = false

  deinit {
    saveContext()
  }

  init(isPreview: Bool = false) {
    super.init()
    self.isPreviewContext = isPreview
    configureContainer()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(CoreDataStack.shouldSaveContext(_:)),
      name: UIApplication.willTerminateNotification,
      object: nil)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(CoreDataStack.shouldSaveContext(_:)),
      name: UIApplication.willResignActiveNotification,
      object: nil)
  }

  @objc func shouldSaveContext(_ note: Notification) {
    NSLog("saving document")
    saveContext()
  }

  func configureContainer() {
    let preview = URL(fileURLWithPath: "/dev/null")
    let prod = AppURLS.documentsDirectory().appendingPathComponent("recipes.sqlite")
    let url = isPreviewContext ?  preview:prod
    let storeDescription = makeStore(at: url)
    container.persistentStoreDescriptions = [storeDescription]
    container.loadPersistentStores { _, error in
      if let error = error {
        print("error: in core data load ", error)
      }

      self.container.viewContext.undoManager = UndoManager()
    }
  }

  func makeStore(at url: URL) -> NSPersistentStoreDescription {
    let storeDescription = NSPersistentStoreDescription(url: url)
    if isPreviewContext {
      storeDescription.type = NSInMemoryStoreType
    } else {
      storeDescription.type = NSSQLiteStoreType
    }
    return storeDescription
  }

  var viewContext: NSManagedObjectContext {
    return container.viewContext
  }

  func saveContext() {
    if self.viewContext.hasChanges && !isPreviewContext {
      print("MOC save")
      do {
        try self.viewContext.save()
      } catch {
        print("MOC save error", error)
      }
    }
  }
}
