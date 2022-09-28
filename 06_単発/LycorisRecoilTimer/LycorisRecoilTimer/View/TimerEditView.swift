//
//  TimerEditView.swift
//  LycorisRecoilTimer
//
//  Created by HIROKI IKEUCHI on 2022/09/28.
//

import SwiftUI

struct TimerEditView: View {
    
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Remaining time")
                .font(.title)
                .padding(.vertical)
            Text("\(String(format: "%02d", hour)) : \(String(format: "%02d", minute)) : \(String(format: "%02d", second))")
                .font(.title2)
            TimePicker(hour: $hour, minute: $minute, second: $second)
                .frame(width: 200)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        TimerEditView(hour: .constant(0), minute: .constant(0), second: .constant(0))
    }
}
