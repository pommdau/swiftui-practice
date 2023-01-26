//
//  ViewsUsingStateAndEnvironmentOrEnvironmentObjectView2.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import SwiftUI

struct ViewsUsingStateAndEnvironmentOrEnvironmentObjectView2: View {
    
    @State var flag: Bool = false
    internal let inspection = Inspection<Self>()  // For ViewInspector Tests
    
    var body: some View {
        Button {
            flag.toggle()
        } label: {
            Text(flag ? "True" : "False")
        }
        .onReceive(inspection.notice, perform: { output in
            inspection.visit(self, output)  // For ViewInspector Tests
        })
    }
}

struct ViewsUsingStateAndEnvironmentOrEnvironmentObjectView2_Previews: PreviewProvider {
    static var previews: some View {
        ViewsUsingStateAndEnvironmentOrEnvironmentObjectView2()
    }
}
