//
//  ContentView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    
    var body: some View {        
        TimerView()

//        Text(viewModel.timerText)
//            .font(.system(.title, design: .monospaced))
//            .onAppear() {
//                viewModel.startTimer()
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


