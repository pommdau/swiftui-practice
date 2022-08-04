//
//  MultipleDonwloadRowView.swift
//  SwiftConcurrencyCheatsheetDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct MultipleDonwloadRowView: View {
    
    let name: String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Button {
                print("donwload")
            } label: {
                Image(systemName: "square.and.arrow.down")
            }
        }
    }
}

struct MultipleDonwloadRowView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleDonwloadRowView(name: "Filex")
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
