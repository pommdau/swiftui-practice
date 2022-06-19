//
//  ContentView.swift
//  SwiftChart
//
//  Created by HIROKI IKEUCHI on 2022/06/14.
//

import SwiftUI
import Charts

struct ChartEntry: Identifiable {
    var title: String
    var value: Double
    var color: Color = .green
    var id: String {
        return title + String(value)
    }
}

struct ContentView: View {
    var body: some View {
        
        let data: [ChartEntry] = [
            .init(title: "A", value: 5),
            .init(title: "B", value: 10),
            .init(title: "C", value: 8)
        ]

        Chart(data) { dataPoint in
            BarMark(
                x: .value("タイトル", dataPoint.title),
                y: .value("値", dataPoint.value)
            )
            .foregroundStyle(dataPoint.color)
        }
        .frame(height: 200)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
