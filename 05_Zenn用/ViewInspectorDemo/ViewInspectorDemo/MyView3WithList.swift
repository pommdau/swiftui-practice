//
//  MyView3WithList.swift
//  ViewInspectorDemo
//
//  Created by HIROKI IKEUCHI on 2022/12/23.
//

import SwiftUI

struct MyView3WithList: View {
    
    private let titles = ["hoge", "fuga", "piyo"]
    
    var body: some View {
        List(titles, id: \.self) { title in
            Text(title)
        }
    }
}

struct MyView3WithList_Previews: PreviewProvider {
    static var previews: some View {
        MyView3WithList()
    }
}
