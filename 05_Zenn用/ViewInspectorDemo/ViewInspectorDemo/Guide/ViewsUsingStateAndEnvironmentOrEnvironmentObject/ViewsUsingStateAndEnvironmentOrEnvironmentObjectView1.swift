//
//  ViewsUsingStateAndEnvironmentOrEnvironmentObjectView1.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import SwiftUI

struct ViewsUsingStateAndEnvironmentOrEnvironmentObjectView1: View {
    
    @State var flag: Bool = false
    internal var didAppear: ((Self) -> Void)?  // For ViewInspector Tests
    
    var body: some View {
        Button {
            flag.toggle()
        } label: {
            Text(flag ? "True" : "False")
        }
        .onAppear {
            didAppear?(self)  // For ViewInspector Tests
        }
    }
}

struct ViewsUsingStateAndEnvironmentOrEnvironmentObjectView1_Previews: PreviewProvider {
    static var previews: some View {
        ViewsUsingStateAndEnvironmentOrEnvironmentObjectView1()
    }
}
