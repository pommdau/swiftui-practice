

import SwiftUI

struct ScoreView: View {
    
    var numberOfQuestions = 5
    
    class State {
        var numberOfAnswered = 0
    }
    
    var state = State()
    
    var body: some View {
        
        Button {
            self.state.numberOfAnswered += 1
            print("Answered: \(self.state.numberOfAnswered)")
        } label: {
            HStack {
                Text("\(state.numberOfAnswered)/\(numberOfQuestions)")
                    .font(.caption)
                    .padding(4)
                Spacer()
            }
        }

    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
