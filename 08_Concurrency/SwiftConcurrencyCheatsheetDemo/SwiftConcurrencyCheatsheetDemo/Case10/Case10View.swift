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
        
        return ["1", "2"]                
    }
    
}

struct Case10View_Previews: PreviewProvider {
    static var previews: some View {
        Case10View()
    }
}
