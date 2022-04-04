import SwiftUI

@main
struct KuchiApp: App {
    
    let userManager = UserManager()
    
    init() {
        userManager.load()
    }
    
    var body: some Scene {
        WindowGroup {
            RegisterView()
                .environmentObject(userManager)
        }
    }
}

struct KuchiApp_Previews: PreviewProvider {
    
    static let userManager = UserManager(name: "Ray")
    
    static var previews: some View {
        RegisterView()
            .environmentObject(userManager)
    }
}
