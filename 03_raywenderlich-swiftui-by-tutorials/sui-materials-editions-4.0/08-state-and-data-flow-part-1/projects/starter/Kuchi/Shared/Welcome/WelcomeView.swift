import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var userManager: UserManager
    @ObservedObject var challengesViewModel = ChallengesViewModel()
    @State var showPractice = false
    
    @ViewBuilder
    var body: some View {
        if showPractice {
            PracticeView(
                challengeTest: $challengesViewModel.currentChallenge,
                userName: $userManager.profile.name
            )
        } else {
            ZStack {
                WelcomeBackgroundImage()
                
                VStack {
                    Text(verbatim: "Hi, \(userManager.profile.name)")
                    
                    WelcomeMessageView()
                    
                    Button {
                        showPractice = true
                    } label: {
                        HStack {
                            Image(systemName: "play")
                            Text(verbatim: "Start")
                        }
                    }
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(UserManager())
    }
}
