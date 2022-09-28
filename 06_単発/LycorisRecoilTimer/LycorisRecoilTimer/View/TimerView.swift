//
//  TimerView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {
        ZStack {
                                    
            Color.red
                .ignoresSafeArea()
            VStack {
                Toggle(isOn: $viewModel.isTimerValid) {
                    Text("HogeHoge")
                }
                HeadertText()
                    .padding(.horizontal)
                Robot()
                    .padding(.horizontal)
                FooterText()
                    .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    private func HeadertText() -> some View {
        if viewModel.isTimerValid {
            Text("PUNISHMENT")
                .lineLimit(1)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
        } else {
            Text("PUNISHMENT")
                .glowEffectText()
        }
    }
    
    @ViewBuilder
    private func FooterText() -> some View {
        if viewModel.isTimerValid {
            Text("EXPLOSION!!!")
                .lineLimit(1)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
        } else {
            Text("EXPLOSION!!!")
                .glowEffectText()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
