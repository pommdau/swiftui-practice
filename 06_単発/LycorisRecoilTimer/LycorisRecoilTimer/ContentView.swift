//
//  ContentView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = TimerViewModel()
    
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var second: Int = 0
    
    var body: some View {
        VStack(alignment: .center) {
            Text("設定時間")
                .font(.title)
                .padding(.vertical)
            Text("\(String(format: "%02d", hour))時 \(String(format: "%02d", minute))分 \(String(format: "%02d", second))秒")
                .font(.title2)
            TimePicker(hour: $hour, minute: $minute, second: $second)
                .frame(width: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


