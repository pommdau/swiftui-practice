//
//  Case11View.swift
//  SwiftConcurrencyCheatsheetDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct Case11View: View {
    
    @State private var firstMessage: String = "1st messaage"
    @State private var secondMessage: String = "2nd messaage"
    @State private var task: Task<(), Never>?
    
    var body: some View {
        VStack {
            Text("Case11 View")
                .font(.title)
            
            Text(firstMessage)
            Text(secondMessage)
                .padding(.bottom, 20)
                        
            Button {
                task = Task {
                    do {
                        let messages = try await getNewMessages(for: [firstMessage, secondMessage])
                        firstMessage = messages[0]
                        secondMessage = messages[1]
                    } catch {
                        if Task.isCancelled {
                            print("キャンセルボタンが押されました")
                        } else {
                            print("エラーが発生しました。")
                        }
                    }
                }
            } label: {
                Text("Download")
            }
            
            Button {
                print("cancel button")
                task?.cancel()
                task = nil
            } label: {
                Text("Cancel")
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

        // ダミーの重い処理
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)

        return "\(message) +"
    }
}

struct Case11View_Previews: PreviewProvider {
    static var previews: some View {
        Case11View()
    }
}
