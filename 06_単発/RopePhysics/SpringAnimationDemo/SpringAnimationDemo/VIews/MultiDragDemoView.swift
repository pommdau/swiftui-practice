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
    let colors: [Color] = [.red, .green, .blue]
//    let soundBox = SoundBox()
    
    var body: some View {
        
        //            This came from https://www.youtube.com/watch?v=ffV_fYcFoX0&t=6175s
        HStack {
            ForEach(0 ..< colors.count) { index in
                SoundView(active: $soundStates[index], sound: colors[index])
                    .overlay(
                        //            Creating an overlay creates a view that matches the size of the original view
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    //            Insert that into a state array, and now can access the coordinates of frames
                                    soundFrames.insert((geo.frame(in: .global)), at: 0)
                                }
                        }
                    )
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged({ (value) in
                    
                    // If there's a match activate the view by toggling state
                    if let match = soundFrames.firstIndex(where: { $0.contains(value.location) }) {
                        soundStates[match] = true
                    } else {
                        deactivateSounds()
                    }
                })
                    .onEnded({ (_) in
                        deactivateSounds()
                    })
            )
        }
    }
    
    private func deactivateSounds() {
        for index in soundStates.indices {
            soundStates[index] = false
        }
    }
}

struct SoundView: View {
    @Binding var active: Bool
    
    let sound: Color
//    let soundBox = SoundBox()
    
    var body: some View {
        
        Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(sound.opacity(0.3))
        
//        VStack {
//            Text(sound.text)
//                .padding()
//                .font(sound.length == .silent ? .body : .largeTitle)
//            if sound.symbol != nil {
//                Image(systemName: sound.symbol!)
//            }
//        }
        .background(combo())
        //        For iOS 14
        .onChange(of: active) { (active) in
            print("🐱: \(active)")
        }
    }
    
    private func combo() -> Color {
        if active == true {
            
            return .orange
        } else {
//            soundBox.stopPlayers()
            return Color.clear
        }
    }
}

struct MultiDragDemoView_Previews: PreviewProvider {
    static var previews: some View {
        MultiDragDemoView()
    }
}
