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
 
 */

@Reducer
struct CounterFeature {
    
    @ObservableState
    struct State {
        var count = 0
    }
    
    enum Action {
        // ユーザがUIで実行することを文字通り命名する
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        // state:  CounterFeature.State
        // action: CounterFeature.Action
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                return .none
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
