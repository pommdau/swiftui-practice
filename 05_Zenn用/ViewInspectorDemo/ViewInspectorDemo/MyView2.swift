//
//  MyView2.swift
//  ViewInspectorDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/23.
//

import SwiftUI

struct MyView2: View {
    var body: some View {
        VStack {
            HStack {
                Text("text1")
                Text("text2")
            }
            
            Button {
                print("button1")
            } label: {
                Text("button1")
            }
            
            Button {
                print("playButton")
            } label: {
                Text("PlayButton")
            }
            .accessibilityLabel("Play button")  // アクセシビリティの読み上げ用
            .accessibilityIdentifier("play_button")  // 開発者向け
        }
    }
}

struct MyView2_Previews: PreviewProvider {
    static var previews: some View {
        MyView2()
    }
}
