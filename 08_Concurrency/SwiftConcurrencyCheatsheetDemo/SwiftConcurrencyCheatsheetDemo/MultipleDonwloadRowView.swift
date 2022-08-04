//
//  MultipleDonwloadRowView.swift
//  SwiftConcurrencyCheatsheetDemo
//
//  Created by HIROKI IKEUCHI on 2022/08/04.
//

import SwiftUI

struct MultipleDonwloadRowView: View {
    
    enum DownloadState {
        case none
        case downloading
        case downloaded
        case error
    }
    
    @State private var task: Task<(), Never>?
    @State private var isShowingErrorPopover = false
    
    let name: String
    @State var state: DownloadState = .none
    
    
    var body: some View {
        HStack {
            Text(name)
            if state == .downloading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding(.leading, 8)
            } else if state == .downloaded {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.green)
            } else if state == .error {
                Button {
                    isShowingErrorPopover = true
                } label: {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.orange)
                }
                .popover(isPresented: $isShowingErrorPopover, arrowEdge: .leading) {
                    Text("吹き出しです")
                        .padding()
                }
            }

            Spacer()
            
            Button {
                handleButtonTapped()
            } label: {
                switch state {
                case .none, .error:
                    Text("ダウンロード")
                case .downloading:
                    HStack {
                        Text("キャンセル")
                    }
                case .downloaded:
                    Text("アンインストール…")
                        .foregroundColor(.red)
                }
            }
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    
    private func handleButtonTapped() {
        
        switch state {
        case .none, .error:
            task = Task {
                do {
                    state = .downloading
                    let _ = try await downloadFile(for: name,
                                                   throwingError: true)
                    state = .downloaded
                } catch {
                    if Task.isCancelled {
                        state = .none
                    } else {
                        state = .error
                    }
                }
            }
        case .downloading:
            task?.cancel()
            task = nil
        case .downloaded:
            print("uninstall")
            state = .none
        }
    }
    
    // TODO: replace String to URL
    private func downloadFile(for file: String,
                              throwingError: Bool = false) async throws -> String {
        print("getNewMessage")
        if throwingError {
            throw NSError(domain: "error message", code: -1, userInfo: nil)
        }
        
        // ダミーの重い処理
        //        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)  // 3s
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        return "\(file) +"
    }
}

struct MultipleDonwloadRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MultipleDonwloadRowView(name: "sample_file", state: .none)
                .previewLayout(.fixed(width: 300, height: 100))
            MultipleDonwloadRowView(name: "sample_file", state: .downloading)
                .previewLayout(.fixed(width: 300, height: 100))
            MultipleDonwloadRowView(name: "sample_file", state: .downloaded)
                .previewLayout(.fixed(width: 300, height: 100))
            MultipleDonwloadRowView(name: "sample_file", state: .error)
                .previewLayout(.fixed(width: 300, height: 100))
        }
    }
}
