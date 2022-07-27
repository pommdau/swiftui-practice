//
//  ContentView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/26.
//

import SwiftUI

class PhysicsManager: ObservableObject {
    var count: Int = 0
    private var timer: Timer? = nil
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.count += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
        
}

struct ContentView: View {
        
//    private let standardHeight: CGFloat = 400
//    @State private var yOffset: CGFloat = 10
    
    @ObservedObject var physicsManager = PhysicsManager()
    
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 1)) { _ in
            Text("\(physicsManager.count)")
        }
        
//        GeometryReader { geometry in
//            TimelineView(.periodic(from: Date(), by: 1)) { context in
//                VStack {
//                    Text("\(context.date)")
//                    Circle()
//                        .frame(width: 30, height: 30)
//                        .position(CGPoint(x: geometry.size.width / 2,
//                                          y: geometry.size.height / 2 + yOffset))
//                        .foregroundColor(.red)
//
//                }
//            }
//        }
            .onAppear {
                physicsManager.startTimer()
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
