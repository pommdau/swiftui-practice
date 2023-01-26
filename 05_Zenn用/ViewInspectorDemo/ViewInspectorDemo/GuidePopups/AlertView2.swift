//
//  AlertView2.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/19.
//
//  ref: [【SwiftUI】アラートの使い方（alert）](https://capibara1969.com/3757/)

import SwiftUI

struct AlertView2: View {
    @State var isShowingAlert: Bool = false
    internal let inspection = Inspection<Self>()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button {
                isShowingAlert.toggle()
            } label: {
                Text("Toggle")
            }
            
        }
        .onReceive(inspection.notice, perform: { output in
            inspection.visit(self, output)  // For ViewInspector Tests
        })
        .alert("Title", isPresented: $isShowingAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Remove", role: .destructive) {}
            
        } message: {
            Text("Message")
        }

    }
}

struct AlertView2_Previews: PreviewProvider {
    static var previews: some View {
        AlertView2()
    }
}
