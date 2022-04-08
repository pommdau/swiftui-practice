

import SwiftUI

struct ScoreView: View {
    let numberOfQuestions: Int
    @State var numberOfAnswered = 0
    
    var body: some View {
        HStack {
            Text("\(numberOfAnswered)/\(numberOfQuestions)")
                .font(.caption)
                .padding(4)
            Spacer()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(numberOfQuestions: 5)
    }
}
