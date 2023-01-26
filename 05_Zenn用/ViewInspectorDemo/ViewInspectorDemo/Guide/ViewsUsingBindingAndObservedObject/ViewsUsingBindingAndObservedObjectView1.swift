//
//  ViewsUsingBindingAndObservedObjectView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import SwiftUI

struct ViewsUsingBindingAndObservedObjectView1: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Status: ")
                if isOn {
                    Text("ON")
                } else {
                    Text("OFF")
                }
            }
            .padding(.bottom, 8)
            
            Button {
                isOn.toggle()
            } label: {
                Text("Toggle status")
            }

        }
    }
}

struct Parent_ViewsUsingBindingAndObservedObjectView1: View {
    @State private var isOn = false
    var body: some View {
        ViewsUsingBindingAndObservedObjectView1(isOn: $isOn)
    }
    
}

struct ViewsUsingBindingAndObservedObjectView1_Previews: PreviewProvider {
    static var previews: some View {
//        ViewsUsingBindingAndObservedObjectView1(isOn: .constant(false))
        Parent_ViewsUsingBindingAndObservedObjectView1()
    }
}
