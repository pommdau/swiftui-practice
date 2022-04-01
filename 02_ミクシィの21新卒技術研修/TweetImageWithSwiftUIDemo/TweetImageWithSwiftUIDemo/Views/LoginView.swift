//
//  LoginView.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            HStack {
                Image("TwitterMark")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Welcome, TweetMuseum!")
            }
            
            Button(
                action: {
                    print("do login action")
                },
                label: {
                    Text("Login...")
                })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
