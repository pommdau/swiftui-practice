//
//  Case9RowView.swift
//  SwiftConcurrencyCheatsheetDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct Case9RowView: View {
    
    enum DownloadStatus {
        case none
        case downloading
        case downloaded
        case error
    }
    
    var message: String
    var status: DownloadStatus
    
    var body: some View {
        HStack {
            Text(message)
            
            Button {
                print("hoge hoge")
            } label: {
                switch status {
                case .none:
                    Image(systemName: "square.and.arrow.down")
                case .downloading:
                    ActivityIndicator()
                case .downloaded:
                    Image(systemName: "checkmark.circle")
                case .error:
                    Image(systemName: "exclamationmark.triangle")
                }
            }
        }
    }
}

struct Case9RowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Case9RowView(message: "sample-message", status: .none)
                .previewLayout(.fixed(width: 300, height: 200))
            Case9RowView(message: "sample-message", status: .downloading)
                .previewLayout(.fixed(width: 300, height: 200))
            Case9RowView(message: "sample-message", status: .downloaded)
                .previewLayout(.fixed(width: 300, height: 200))
            Case9RowView(message: "sample-message", status: .error)
                .previewLayout(.fixed(width: 300, height: 200))
        }
    }
}
