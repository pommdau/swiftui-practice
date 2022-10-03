# リコリコ13話のロボ太タイマー

https://user-images.githubusercontent.com/29433103/193056952-fc71ec66-4e31-41a3-946c-f9cdf3ec41c4.mov

## スクリーンショット


## 参考
- 等幅フォント
    - [Display high precision time with Duration and TimeFormatStyle](https://nilcoalescing.com/blog/DurationAndTimeFormatStyle/)

## Duration
    
- [Duration](https://developer.apple.com/documentation/swift/duration?changes=_8)
- [Duration\.TimeFormatStyle](https://developer.apple.com/documentation/swift/duration/timeformatstyle?changes=l_4_6)
- [【Swift】日時、数、通貨、データサイズ、リスト、人の名前、単位付きの数から String へのフォーマットは自分で実装しないで](https://qiita.com/treastrain/items/e0e9c3e9f517fa20ad08)
- 何個か問題があるのでスキップ…

```swift
import SwiftUI

struct ContentView: View {
    
    enum TimerState {
        case inReady
        case inProgress
        case isTimerOver
    }
    
    @State var timeRemaining: Duration = .seconds(10.1)
    @State private var state: TimerState = .inReady
    @State private var timer: Timer? = nil
    @State private var startTime: TimeInterval = Date.timeIntervalSinceReferenceDate
    
    var body: some View {
        VStack(spacing: 12) {
            durationText()
            Button("Start") {
                timer = nil
                state = .inProgress
                // TODO: エレガントじゃない…
                startTime = Date.timeIntervalSinceReferenceDate
                + Double(timeRemaining.components.seconds)
                + Double(timeRemaining.components.attoseconds) / 100000000000000000.0
                print(timeRemaining.components.attoseconds)
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                    let remainTime = self.startTime - Date.timeIntervalSinceReferenceDate
                    self.timeRemaining = .seconds(remainTime)
                    print(remainTime)
                }
            }
        }
    }
    
    @ViewBuilder
    private func durationText() -> some View {
        let durationString = timeRemaining.formatted(
            .time(
                pattern: .minuteSecond(padMinuteToLength: 2, fractionalSecondsLength: 2)
            )
        )
        Text(durationString)
            .monospacedDigit()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```