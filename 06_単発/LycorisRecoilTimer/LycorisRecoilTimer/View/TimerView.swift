//
//  TimerView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    @State private var isPresentingTimerEditView = false
    
    var body: some View {
        ZStack {
            backgroundColor(state: viewModel.state)
            VStack {
                HeadertText()
                    .padding()
                Robot(timerString: viewModel.timerText,
                      timerState: viewModel.state,
                      leftEyeTapped: {
                    isPresentingTimerEditView = true
                    viewModel.remainTimeBuffer = viewModel.remainTime
                },
                      rightEyeTapped: {
                    viewModel.rightEyeClicked()
                })
                .padding(.horizontal)
                FooterText()
                    .padding()
            }
        }
        .ignoresSafeArea(edges: [.bottom, .leading, .trailing])

        .sheet(isPresented: $isPresentingTimerEditView) {
            timerEditView()
        }
        
    }
    
    @ViewBuilder
    private func timerEditView() -> some View {
        NavigationView {
            TimerEditView(time: $viewModel.remainTimeBuffer)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingTimerEditView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isPresentingTimerEditView = false
                            viewModel.remainTime = viewModel.remainTimeBuffer
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    private func HeadertText() -> some View {
        switch viewModel.state {
        case .inReady, .inProgress:
            Text("PUNISHMENT")
                .glowEffectText()
        case .isTimerOver:
            Text("PUNISHMENT")
                .lineLimit(1)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
        }
    }
    
    @ViewBuilder
    private func FooterText() -> some View {
        switch viewModel.state {
        case .inReady, .inProgress:
            Text("EXPLOSION!!!")
                .glowEffectText()
        case .isTimerOver:
            Text("EXPLOSION!!!")
                .lineLimit(1)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
        }
    }
    
    private func backgroundColor(state: TimerState) -> Color {
        switch state {
        case .inReady:
            return .green
        case .inProgress, .isTimerOver:
            return .red
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
