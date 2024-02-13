//
//  AppFeature.swift
//  TCADemo2
//
//  Created by HIROKI IKEUCHI on 2024/02/13.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Reducer

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
    }
    
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        // CounterFeatureをAppFeatureに構成する際、ScopeというReducerが使える
        Scope(state: \.tab1, action: \.tab1) {
            // child
            CounterFeature()
        }
        
        Scope(state: \.tab2, action: \.tab2) {
            // child
            CounterFeature()
        }
        
        Reduce { state, action in
            // Core logic of the app feature
            return .none
        }
    }
}


// MARK: - View

struct AppView: View {
    
    let store1: StoreOf<CounterFeature>
    let store2: StoreOf<CounterFeature>
    
    var body: some View {
        TabView {
            CounterView(store: store1)
                .tabItem {
                    Text("Counter 1")
                }
            
            CounterView(store: store2)
                .tabItem {
                    Text("Counter 2")
                }
        }
    }
}
