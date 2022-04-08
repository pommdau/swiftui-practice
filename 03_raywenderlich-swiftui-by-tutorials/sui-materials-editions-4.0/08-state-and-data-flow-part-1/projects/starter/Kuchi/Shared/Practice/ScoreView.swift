

import SwiftUI

struct ScoreView: View {
    
    class Box<T> {
        var wrappedValue: T
        init(initialValue value: T) {
            self.wrappedValue = value
        }
    }
    
    
    var numberOfQuestions = 5
    
    struct State {
        var numberOfAnswered = Box<Int>(initialValue: 0)
    }
    
    var state = State()
    
    var body: some View {
        
        Button {
            self.state.numberOfAnswered.wrappedValue += 1
            print("Answered: \(self.state.numberOfAnswered.wrappedValue)")
        } label: {
            HStack {
                Text("\(state.numberOfAnswered.wrappedValue)/\(numberOfQuestions)")
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
