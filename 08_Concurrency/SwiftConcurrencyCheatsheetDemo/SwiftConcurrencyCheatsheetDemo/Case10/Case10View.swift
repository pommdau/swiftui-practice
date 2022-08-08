//
//  Case10View.swift
//  SwiftConcurrencyCheatsheetDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct Case10View: View {
    
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
                    let messages = try await getNewMessages(for: [firstMessage, secondMessage])
                    firstMessage = messages[0]
                    secondMessage = messages[1]
                }
                
            } label: {
                Text("Function")
            }
        }
    }
    
    private func getNewMessages(for messages: [String]) async throws -> [String] {
        try await withThrowingTaskGroup(of: String.self) { group in
            for message in messages {
                // すぐに以下のChild Task: getNewMessageは並行に実行されます
                group.addTask {
                    print("group.addTask")
                    return try await getNewMessage(for: message)
                }
            }
            Thread.sleep(forTimeInterval: 2.0)
            print("var newMessages: [String] = []")
            var newMessages: [String] = []
            // group から Child Task の結果を取り出すときに await して待ち合わせます
            for try await newMessage in group {
                print("newMessages.append(newMessage)")
                newMessages.append(newMessage)
            }
            
            return newMessages
        }
    }
    
    private func getNewMessage(for message: String,
                               throwingError: Bool = false) async throws -> String {
        print("getNewMessage")
        if throwingError {
            throw NSError(domain: "error message", code: -1, userInfo: nil)
        }

        // 重い処理の想定
        Thread.sleep(forTimeInterval: 0.5)

        return "\(message) +"
    }
}

struct Case10View_Previews: PreviewProvider {
    static var previews: some View {
        Case10View()
    }
}
