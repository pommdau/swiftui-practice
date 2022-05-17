import UIKit
import SwiftUI
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    RealmMigrator.setDefaultConfiguration()
    
    if let windowScene = scene as? UIWindowScene {
      do {
        let realm = try Realm()
        let window = UIWindow(windowScene: windowScene)
        
        let contentView = ContentView()
          .environmentObject(IngredientStore(realm: realm))
        
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
      } catch let error {
        fatalError("Failed to open Realm. Error: \(error.localizedDescription)")
      }
    }
    
  }
}
