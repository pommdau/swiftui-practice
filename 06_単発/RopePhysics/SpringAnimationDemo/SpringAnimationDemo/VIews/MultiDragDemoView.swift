//
//  MultiDragDemoView.swift
//  SpringAnimationDemo
//
//  Created by HIROKI IKEUCHI on 2022/07/28.
//

import SwiftUI

struct MultiDragDemoView: View {
    
    
    @State private var soundFrames = [CGRect]()
    @State private var soundStates = [false, false, false]
    
    //    let sounds: MultiSound
    //    let soundBox = SoundBox()
    
    var body: some View {
                
        VStack {
            
            switch soundFrames.count {
            case 1:
                Text("\(soundFrames[0].debugDescription), \(soundStates[0] ? "true" : "false")")
            case 2:
                Text("\(soundFrames[0].debugDescription), \(soundStates[0] ? "true" : "false")")
                Text("\(soundFrames[1].debugDescription), \(soundStates[1] ? "true" : "false")")
            case 3:
                Text("\(soundFrames[0].debugDescription), \(soundStates[0] ? "true" : "false")")
                Text("\(soundFrames[1].debugDescription), \(soundStates[1] ? "true" : "false")")
                Text("\(soundFrames[2].debugDescription), \(soundStates[2] ? "true" : "false")")
            default:
                Text("(none)")
            }
            
            HStack {
                ForEach(0 ..< 3) { index in
                    //                SoundView(active: $soundStates[index], sound: sound[index])
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Bool.random() ? .red : .blue)
                        .overlay(
                            // Creating an overlay creates a view that matches the size of the original view
                            GeometryReader { geo in
                                Color.clear
                                    .onAppear {
                                        // Insert that into a state array, and now can access the coordinates of frames
                                        soundFrames.insert((geo.frame(in: .global)), at: 0)
                                    }
                            }
                        )
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged({ (value) in
                        print(value.location)
                        // If there's a match activate the view by toggling state
                        if let match = soundFrames.firstIndex(where: { $0.contains(value.location) }) {
                            soundStates[match] = true
                        } else {
                            //                        deactivateSounds()
                        }
                    })
                        .onEnded({ (_) in
                            //                        deactivateSounds()
                        })
                )
            }
            
        }
    }
    
}

struct MultiDragDemoView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDragDemoView()
    }
}
