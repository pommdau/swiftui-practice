//
//  Case9View.swift
//  SwiftConcurrencyCheatsheetDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct Case9View: View {
        
    @State private var firstMessage: String = "1st messaage"
    @State private var secondMessage: String = "2nd messaage"
    
    var body: some View {
        VStack {
            Text("Case9 View")
                .font(.title)
            
            Text(firstMessage)
            Text(secondMessage)
            
            Spacer()
            
            Button {
                
                Task {
                    let messages = try await getAppendedMessages()
                    firstMessage = messages.first
                    secondMessage = messages.second
                }
                
            } label: {
                Text("Function")
            }
        }
    }
    
    // MARK: - Helpers
    
    private func appendSuffix(withMessage message: String,
                              throwingError: Bool = false) async throws -> String {
        if throwingError {
            throw NSError(domain: "error message", code: -1, userInfo: nil)
        }

        // 重い処理の想定
        Thread.sleep(forTimeInterval: 0.5)

        return "\(message) +"
    }

    private func getAppendedMessages() async throws -> (first: String, second: String) {
        async let firstDownloadedMessage = appendSuffix(withMessage: firstMessage)
        async let secondDownloadedMessage = appendSuffix(withMessage: secondMessage)
        
        let messages = try await (first: firstDownloadedMessage, second: secondDownloadedMessage)
        return messages
    }
    
}

struct Case9View_Previews: PreviewProvider {
    static var previews: some View {
        Case9View()
    }
}
