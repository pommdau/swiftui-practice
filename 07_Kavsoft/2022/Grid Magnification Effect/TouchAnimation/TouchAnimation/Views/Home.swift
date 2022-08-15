//
//  Home.swift
//  TouchAnimation
//
//  Created by HIROKI IKEUCHI on 2022/08/15.
//

import SwiftUI

struct Home: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            //  MARK: To Fit Into Whole View
            // Calculating Item Count with the help of Height & Width
            // In a Row We Have 10 Items
            let width = (size.width / 10)
            
            // Multiplying Each Row Count
            let itemCount = Int((size.height / width).rounded()) * 10
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10)) {
                ForEach(0..<itemCount, id: \.self) { _ in
                    GeometryReader { innerProxy in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.orange)
                    }
                    .padding(5)
                    .frame(height: width)
                }
            }
        }
        .padding(15)
        .preferredColorScheme(.dark)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
