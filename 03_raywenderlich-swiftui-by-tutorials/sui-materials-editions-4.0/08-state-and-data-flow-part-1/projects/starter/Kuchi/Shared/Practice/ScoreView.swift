

import SwiftUI

struct ScoreView: View {
    let numberOfQuestions: Int
    @State var numberOfAnswered: Int
    
    var body: some View {
        HStack {
            Text("\(numberOfAnswered)/\(numberOfQuestions)")
                .font(.caption)
                .padding(4)
            Text("ScoreView Counter: \(numberOfAnswered)")
            Spacer()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    
    @State static var numberOfAnswered: Int = 0
    
    static var previews: some View {
        ScoreView(numberOfQuestions: 5,
                  numberOfAnswered: numberOfAnswered)
    }
}
