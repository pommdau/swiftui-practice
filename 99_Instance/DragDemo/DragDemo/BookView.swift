//
//  BookView.swift
//  DragDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/30.
//

import SwiftUI

struct BookView: View {
    
    @Binding var book: Book
    
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
//                            print(value.location)
                            book.positon = CGPoint(x: book.positon.x + 0.1, y: book.positon.y + 0.1)
                        })
                        .onEnded({ value in
                            book.positon = CGPoint(x: book.positon.x + 10, y: book.positon.y + 10)
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
