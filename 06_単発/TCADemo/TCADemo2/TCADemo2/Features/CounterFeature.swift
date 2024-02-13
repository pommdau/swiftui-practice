//
//  CounterFeature.swift
//  TCADemo2
//
//  Created by HIROKI IKEUCHI on 2024/02/13.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Reducer

@Reducer
struct CounterFeature {
    @ObservableState
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
        case timerTick // tick: カチカチいう音
        case toggleTimerButtonTapped
    }
    
    enum CancelID {
        case timer
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
                
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                return .run { [count = state.count ] send in
                    let (data, _) = try await URLSession.shared
                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
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
                        while true {
                            try await Task.sleep(for: .seconds(1))
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

// MARK: - Views

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            countLabel()
            HStack {
                incrementButton()
                decrementButton()
            }            
            timerButton()
            factButton()
            factLabel()
        }
    }
    
    // MARK: - UI Parts
    
    @ViewBuilder
    private func countLabel() -> some View {
        Text("\(store.count)")
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
    }
    
    @ViewBuilder
    private func incrementButton() -> some View {
        Button("-") {
            store.send(.decrementButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
    
    @ViewBuilder
    private func decrementButton() -> some View {
        Button("+") {
            store.send(.incrementButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
    
    @ViewBuilder
    private func timerButton() -> some View {
        Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
            store.send(.toggleTimerButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
    
    @ViewBuilder
    private func factButton() -> some View {
        Button("Fact(Networking)") {
            store.send(.factButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
    }
    
    @ViewBuilder
    private func factLabel() -> some View {
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

// MARK: - Preview

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
