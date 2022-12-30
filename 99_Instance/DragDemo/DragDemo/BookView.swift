//
//  BookView.swift
//  DragDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/30.
//

import SwiftUI

struct BookView: View {
    
    @Binding var book: Book
    @State private var center: CGPoint = .zero  // 初期位置
    @State private var distanceFromCenter: CGPoint = .zero  // オブジェクトの中心とタッチ地点との距離
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
//                book.title += "i"
                book.positon = CGPoint(x: book.positon.x + 10, y: book.positon.y + 10)
            } label: {
                Text("Debug")
            }
            Rectangle()
                .foregroundColor(Color.blue.opacity(0.1))
                .frame(width: 100, height: 200)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            center = .init(x: center.x + 0.1, y: center.y + 0.1)
                            distanceFromCenter = .init(x: distanceFromCenter.x + 0.1, y: distanceFromCenter.y + 0.1)
                            book.positon = CGPoint(x: book.positon.x + 0.1, y: book.positon.y + 0.1)
                            
//                            if distanceFromCenter == .zero {
//                                distanceFromCenter = CGPoint(x: value.startLocation.x - center.x,
//                                                             y: value.startLocation.y - center.y)
//                            } else {
//                                center = CGPoint(x: value.startLocation.x + value.translation.width - distanceFromCenter.x,
//                                                 y: value.startLocation.y + value.translation.height - distanceFromCenter.y)
//                                book.positon = center
//                            }
//                            book.positon = center
                        })
                        .onEnded({ value in
//                            book.positon = CGPoint(x: book.positon.x + 10, y: book.positon.y + 10)
                            distanceFromCenter = .zero
                            center = .zero
                            print("onEnded")
                        })
                )
            
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color.red.opacity(0.1))
                    .frame(width: 300, height: 200)
                Text(book.title)
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(book: .constant(Book()))
    }
}
