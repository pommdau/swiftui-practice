//
//  DynamicQueryWithFindView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/12.
//

import SwiftUI

struct DynamicQueryWithFindView1: View {
    var body: some View {
        VStack {
            HStack {
                Text("Hi")
                Text("Ok")
            }

            Button {
                print("xyz button pressed")
            } label: {
                Text("xyz")
            }
            
            Text("viewWithId: 7")
                .id(7)
            
            Text("viewWithTag: Home")
                .tag("Home")
            
            Button {
                print("play button pressed")
            } label: {
                Text("Play")
            }
            .accessibilityLabel("Play button")
            .accessibilityIdentifier("play_button")            
        }
    }
}

struct DynamicQueryWithFindView1_Previews: PreviewProvider {
    static var previews: some View {
        DynamicQueryWithFindView1()
    }
}
