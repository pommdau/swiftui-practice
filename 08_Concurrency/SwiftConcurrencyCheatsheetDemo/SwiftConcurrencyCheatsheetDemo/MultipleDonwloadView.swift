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
    
    private func getNewMessage(for message: String,
                               throwingError: Bool = false) async throws -> String {
        print("getNewMessage")
        if throwingError {
            throw NSError(domain: "error message", code: -1, userInfo: nil)
        }
        
        // ダミーの重い処理
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        
        return "\(message) +"
    }
}

struct MultipleDonwloadView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleDonwloadView()
    }
}
