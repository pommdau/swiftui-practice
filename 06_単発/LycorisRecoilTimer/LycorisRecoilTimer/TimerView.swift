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
                
                Text("PUNISHMENT")
                    .glowEffectText()
                    .padding(.horizontal)
                
                Robot()
                    .padding(.horizontal)
                
                Text("EXPLOSION!!!")
                    .glowEffectText()
                    .padding(.horizontal)
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
