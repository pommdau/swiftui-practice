//
//  TheBasicsView2.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/12.
//

import SwiftUI

struct TheBasicsView2: View {
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

struct TheBasicsView2_Previews: PreviewProvider {
    static var previews: some View {
        TheBasicsView2()
    }
}
