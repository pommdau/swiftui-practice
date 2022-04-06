
import SwiftUI

struct History: Hashable {
    let date: Date
    let challenge: Challenge
    
    static func random() -> History {
        let date = Date.init(timeIntervalSinceNow: -TimeInterval.random(in: 0...1000000))
        
        let challenge = ChallengesViewModel.challenges.randomElement()!
        
        return History(
            date: date,
            challenge: challenge
        )
    }
    
    static func random(count: Int) -> [History] {
        return (0 ..< count)
            .map({ _ in self.random() })
            .sorted(by: { $0.date < $1.date })
    }
}

struct HistoryView: View {
    let history = History.random(count: 2000)
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var header: some View {
        Text("History")
            .foregroundColor(.white)
            .font(.title)
#if os(iOS)
            .frame(width: UIScreen.main.bounds.width, height: 50)
#endif
            .background(Color.gray)
    }
    
    func getElement(_ element: History) -> some View {
        VStack(alignment: .center) {
            Text("\(dateFormatter.string(from: element.date))")
                .font(.caption2)
                .foregroundColor(.blue)
            HStack {
                VStack {
                    Text("Question:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(element.challenge.question)
                        .font(.body)
                }
                
                VStack {
                    Text("Answer:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(element.challenge.answer)
                        .font(.body)
                }
                
                VStack {
                    Text("Guessed")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(element.challenge.succeeded ? "yes" : "no")
                }
            }
        }
        .padding()
#if os(iOS)
        .frame(width: UIScreen.main.bounds.width)
#endif
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                Section(header: header) {
                    ForEach(history, id: \.self) { element in
                        getElement(element)
                    }
                }
            }
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
