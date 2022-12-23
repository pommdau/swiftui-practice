//
//  MyView.swift
//  ViewInspectorDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/23.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        HStack {
           Text("Hi")
           AnyView(OtherView())
        }
    }
}

struct OtherView: View {
    var body: some View {
        Text("Ok")
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
