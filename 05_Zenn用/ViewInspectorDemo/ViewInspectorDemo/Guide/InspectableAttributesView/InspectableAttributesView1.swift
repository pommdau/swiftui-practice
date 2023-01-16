//
//  InspectableAttributesView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import SwiftUI

struct InspectableAttributesView1: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                MyView(parameter: "Screen 1")
            } label: {
                Text("Continue")
            }
        }
    }
}

struct MyView: View {
    let parameter: String
    var body: some View {
        Text(parameter)
    }
}

struct InspectableAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        InspectableAttributesView1()
    }
}
