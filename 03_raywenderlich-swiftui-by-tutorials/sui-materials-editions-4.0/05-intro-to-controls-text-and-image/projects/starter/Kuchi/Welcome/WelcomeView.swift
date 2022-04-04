import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome to Kikuchi")
            .font(.system(size: 60))
            .bold()
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
