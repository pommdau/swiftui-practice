//
//  SimpleBar.swift
//  GitHubLanguagesDemo
//
//  Created by HIROKI IKEUCHI on 2022/11/28.
//

import SwiftUI
import Charts

struct SimpleBar: View {
    
    var messages: [String] = ["hoge", "fuga", "piyo"]
    
    var body: some View {
        Chart(messages, id: \.self) { message in
            BarMark(
                x: .value("Percentage", Int.random(in: 10...30))
            )
            .foregroundStyle(by: .value("Message", message))
        }
        .chartPlotStyle { plotArea in
            plotArea
                .frame(height: 40)
        }
    }
}

struct SimpleBar_Previews: PreviewProvider {
    static var previews: some View {
        SimpleBar()
            .padding()
    }
}
