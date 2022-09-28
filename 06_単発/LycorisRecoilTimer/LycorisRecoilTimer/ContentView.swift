//
//  ContentView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

class Time: ObservableObject {
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var second: Int = 0
}

struct ContentView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var second: Int = 0
    @State private var isPresentingTimerEditView = false
    
    var body: some View {
        VStack {
            Text("HogeHoge")
            Button {
                isPresentingTimerEditView.toggle()
            } label: {
                Text("TimerEditView")
            }
        }
        .sheet(isPresented: $isPresentingTimerEditView) {
            timerEditView()
        }
    }
    
    @ViewBuilder
    private func timerEditView() -> some View {
        NavigationView {
            TimerEditView(hour: $hour, minute: $minute, second: $second)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingTimerEditView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingTimerEditView = false
                        }
                    }
                }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


