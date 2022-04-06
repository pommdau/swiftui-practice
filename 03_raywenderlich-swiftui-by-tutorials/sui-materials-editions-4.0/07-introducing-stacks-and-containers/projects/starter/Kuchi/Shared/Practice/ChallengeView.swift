import SwiftUI

struct ChallengeView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Welcome to Kuchi").font(.caption)
            Text("Welcome to Kuchi").font(.title)
            Button(action: {}, label: { Text("OK").font(.body) })
        }
    }
    
}


struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        return ChallengeView()
    }
}
