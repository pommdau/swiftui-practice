//
//  ContentView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    @State private var time = Time()
    @State private var timeBuffer = Time()
    @State private var isPresentingTimerEditView = false
    
    var body: some View {
        
        TimerView()
        
//        VStack {
//            Text("\(time.hour):\(time.minute):\(time.second)")
//            Button {
//                isPresentingTimerEditView = true
//                timeBuffer = time
//            } label: {
//                Text("TimerEditView")
//            }
//        }
//        .sheet(isPresented: $isPresentingTimerEditView) {
//            timerEditView()
//        }
    }
    
    @ViewBuilder
    private func timerEditView() -> some View {
        NavigationView {
            TimerEditView(hour: $timeBuffer.hour, minute: $timeBuffer.minute, second: $timeBuffer.second)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingTimerEditView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingTimerEditView = false
                            time = timeBuffer
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


