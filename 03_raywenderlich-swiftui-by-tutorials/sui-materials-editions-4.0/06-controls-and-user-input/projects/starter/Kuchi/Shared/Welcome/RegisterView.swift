import SwiftUI

struct RegisterView: View {
    
    @State var name: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            WelcomeMessageView()
            TextField("Type your name...", text: $name)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.blue)
                )
                .shadow(
                    color: Color.gray.opacity(0.4),
                    radius: 3, x: 1, y: 2)
            Spacer()
        }
        .padding()
        .background(WelcomeBackgroundImage())
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
