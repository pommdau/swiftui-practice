//
//  CounterFeature.swift
//  TCADemo
//
//  Created by HIROKI IKEUCHI on 2024/02/08.
//

import SwiftUI
import ComposableArchitecture

/*
 Reducer: カウンターのロジックをカプセル化
 State: ジョブを実行するために必要な状態を保持する型(通常struct)
 監視する場合は@ObservableStateをつける
 
 TCAにおいてテストの対象はReducerのみ
 
 リデューサーは純粋な関数を形成するため、状態の変更はコンポーザブル アーキテクチャでテストするのが最も簡単な部分です。
 必要なのは、状態の一部とアクションをリデューサーに供給し、状態がどのように変化したかをアサートすることだけです
 
 */

@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action {
        // ユーザがUIで実行することを文字通り命名する
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
        case timerTick
        case toggleTimerButtonTapped
    }
    
    enum CancelID {
        case timer
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    var body: some ReducerOf<Self> {
        // state:  CounterFeature.State
        // action: CounterFeature.Action
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run { [count = state.count] send in
                    try await send(.factResponse(self.numberFact.fetch(count)))
                }
                
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
                
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        for await _ in self.clock.timer(interval: .seconds(1)) {
                            await send(.timerTick)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer)
                }
            }
        }
    }
    
}

/*
 私たちの個人的な好みとしては、それが不可能になるまでリデューサーとビューを
 同じファイル内に保持することですが、タイプを独自のファイルに分割することを
 好む人もいます。
 */

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            // storeから直接値を読みとれる
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            HStack {
                Button("-") {
                    // storeにアクションを送信
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
            
            // MARK: - Timer
            
            Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                store.send(.toggleTimerButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            // MARK: - Fact
            
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}
#Preview {
    // storeには初期状態を渡す
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            // Closure内で機能を提供するReducerを指定
            CounterFeature()
        }
    )
}
