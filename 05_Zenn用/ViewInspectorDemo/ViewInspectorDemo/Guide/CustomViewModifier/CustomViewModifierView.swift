//
//  CustomViewModifierView.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import SwiftUI

struct CustomViewModifierView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!")
                .modifier(MyViewModifier())
            Text("Hello, World!")
                .modifier(MyViewModifier2())
        }
    }
}

struct MyViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top, 15)
    }
}

struct MyViewModifier2: ViewModifier {
    
    var didAppear: ((Self) -> Void)?
    
    func body(content: Content) -> some View {
        content
            .padding(.top, 15)
            .onAppear { self.didAppear?(self) }
    }
}

struct MyViewModifier3: ViewModifier {
    
    let inspection = Inspection<Self>()
    
    func body(content: Content) -> some View {
        content
            .padding(.top, 15)
            .onReceive(inspection.notice) { output in
                inspection.visit(self, output)
            }
    }
}

struct CustomViewModifierView_Previews: PreviewProvider {
    static var previews: some View {
        CustomViewModifierView()
    }
}
