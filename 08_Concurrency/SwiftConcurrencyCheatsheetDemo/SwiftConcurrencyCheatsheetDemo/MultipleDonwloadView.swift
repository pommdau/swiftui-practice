//
//  MultipleDonwloadView.swift
//  SwiftConcurrencyCheatsheetDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct MultipleDonwloadView: View {
    var body: some View {
        List {
            MultipleDonwloadRowView(name: "File1")
            MultipleDonwloadRowView(name: "File2")
            MultipleDonwloadRowView(name: "File3")
        }
    }
}

struct MultipleDonwloadView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleDonwloadView()
    }
}
