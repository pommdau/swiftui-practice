//
//  TimerEditView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import SwiftUI

struct TimerEditView: View {
    
    @Binding var time: Time
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Remaining time")
                .font(.title)
                .padding(.vertical)
            Text("\(String(format: "%02d", time.minute)) : \(String(format: "%02d", time.second))")
                .font(.title2)
            TimePicker(minute: $time.minute, second: $time.second)
                .frame(width: 200)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        TimerEditView(time:.constant(Time(minute: 49, second: 54)))
    }
}
