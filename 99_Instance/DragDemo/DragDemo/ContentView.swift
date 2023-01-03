//
//  ContentView.swift
//  DragDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/30.
//

import SwiftUI

extension CGPoint {
    func toSize() -> CGSize { .init(width:x, height:y) }
}

struct ContentView: View {
    @State var offset: CGSize = .zero

    var body: some View {
        ZStack(alignment: .topLeading) {
            Toolbar(dragOffset: $offset)
                .offset(offset)
            Text(verbatim: "Offset: \(offset)")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct Toolbar: View {
    @Binding var dragOffset: CGSize
    @State private var dragStartOffset: CGSize? = nil
    var body: some View {
        HStack {
            Color.blue.frame(width: 40, height: 40)
                .gesture(drag)
            Color.green.frame(width: 40, height: 40)
            Color.red.frame(width: 40, height: 40)
        }
    }
    var drag: some Gesture {
        DragGesture(coordinateSpace: .global)
           .onChanged { value in
               if dragStartOffset == nil {
                   dragStartOffset = dragOffset
               }
               dragOffset = CGSize(width: dragStartOffset!.width + value.translation.width, height: dragStartOffset!.height + value.translation.height)
           }
           .onEnded { _ in
               dragStartOffset = nil
           }
    }
}

//struct ContentView: View {
//    @GestureState private var dragOffset = CGSize.zero
//    @State private var position = CGSize.zero
//
//    var body: some View {
//        HStack(spacing: 0) {
//            Rectangle()
//                .gesture(
//                    DragGesture()
//                        .updating($dragOffset, body: { (value, state, transaction) in
//                            print(value)
//                            state = value.translation
//                        })
//                        .onEnded({ (value) in
//                            self.position.height += value.translation.height
//                            self.position.width += value.translation.width
//                        })
//                )
//                .foregroundColor(.green)
//                .frame(width: 100, height: 200)
//            Rectangle()
//                .foregroundColor(.blue)
//                .frame(width: 100, height: 200)
//        }
//        .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
//        //            .animation(.easeInOut)
//        .foregroundColor(.green)
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

