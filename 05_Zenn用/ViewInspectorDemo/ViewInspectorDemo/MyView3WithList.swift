//
//  MyView3WithList.swift
//  ViewInspectorDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/23.
//

import SwiftUI

struct MyView3WithList: View {
        
    var body: some View {
        List {
            ForEach(0 ..< 5) { _ in 
                MyView3WithListCell()
            }
        }
    }
}

struct MyView3WithListCell: View {
        
    var body: some View {
        HStack {
            Image(systemName: "doc.fill")
            Text("CellText")
        }
    }
}

struct MyView3WithList_Previews: PreviewProvider {
    static var previews: some View {
        MyView3WithList()
    }
}
