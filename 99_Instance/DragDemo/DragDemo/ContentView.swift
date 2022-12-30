//
//  ContentView.swift
//  DragDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var books = [Book(), Book(), Book()]
    @State private var center: CGPoint = .zero  // 初期位置
    @State private var distanceFromCenter: CGPoint = .zero  // オブジェクトの中心とタッチ地点との距離
    
    var body: some View {
        ZStack {
            ForEach($books) { $book in
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.red.opacity(0.1))
                        .frame(width: 300, height: 200)
                    Text(book.title)
                }
                .position(book.positon)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            if center == .zero {
                                center = book.positon
                            }
                            if distanceFromCenter == .zero {
                                distanceFromCenter = CGPoint(x: value.startLocation.x - center.x,
                                                             y: value.startLocation.y - center.y)
                            } else {
                                center = CGPoint(x: value.startLocation.x + value.translation.width - distanceFromCenter.x,
                                                 y: value.startLocation.y + value.translation.height - distanceFromCenter.y)
                                book.positon = center
                            }
                        })
                        .onEnded({ value in
                            distanceFromCenter = .zero
                            center = .zero
                        })
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

