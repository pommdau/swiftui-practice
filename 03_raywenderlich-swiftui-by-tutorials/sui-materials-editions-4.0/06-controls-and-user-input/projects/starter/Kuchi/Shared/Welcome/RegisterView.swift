import SwiftUI

struct RegisterView: View {
    
    @FocusState var nameFieldFocused: Bool
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            Spacer()
            WelcomeMessageView()
            TextField("Type your name...", text: $userManager.profile.name)
                .submitLabel(.done)
                .bordered()
            Button(action: registerUser) {
                Text("OK")
            }
            Spacer()
        }
        .padding()
        .background(WelcomeBackgroundImage())
    }
}

// MARK: - Event Handlers
extension RegisterView {
    func registerUser() {
        userManager.persistProfile()
    }
}

struct RegisterView_Previews: PreviewProvider {
    
    static let user = UserManager(name: "Ray")
    
    static var previews: some View {
        RegisterView()
            .environmentObject(user)
    }
}
