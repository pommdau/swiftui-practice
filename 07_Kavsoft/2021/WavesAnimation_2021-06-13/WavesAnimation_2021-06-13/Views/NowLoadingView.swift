//
//  NowLoadingView.swift
//  WavesAnimation_2021-06-13
//
//  Created by HIROKI IKEUCHI on 2022/07/21.
//

import SwiftUI

struct NowLoadingView: View {
    
    let interval = 0.5
    let startDate = Date()
    let dots = [
        "",
        ".",
        "..",
        "...",
    ]
    
    var body: some View {
        GeometryReader { bodyView in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: bodyView.size.width * 0.3)
                    
                    Text("Now Loading")
                        .font(.system(size: 24, weight: .semibold, design: .serif))
                    
                    // periodic
                    // from: 開始する時間を指定
                    // by: 更新する秒数を指定します。
                    TimelineView(.periodic(from: startDate, by: interval)) { context in
                        let timeInterval = Date().timeIntervalSince(startDate)
                        let index = Int((timeInterval * 100) / (interval * 100)) % dots.count
                        Text(dots[index])
                            .frame(alignment: .leading)
                            .font(.system(size: 24, weight: .semibold, design: .serif))
                    }
                }
                Spacer()
            }
        }
    }
}

struct NowLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        NowLoadingView()
    }
}
