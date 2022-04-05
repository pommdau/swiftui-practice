import SwiftUI

struct ChallengeView: View {
    var body: some View {
        
        HStack {
          Text("A great and warm welcome to Kuchi")
            .layoutPriority(-1)
            .background(Color.red)

          Text("A great and warm welcome to Kuchi")
            .layoutPriority(1)
            .background(Color.red)

            Text("A great and warm welcome to Kuchi")
                .font(.title)
            .background(Color.red)
            .layoutPriority(-1)
        }
        .background(Color.yellow)
    }
}


struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        return ChallengeView()
    }
}
