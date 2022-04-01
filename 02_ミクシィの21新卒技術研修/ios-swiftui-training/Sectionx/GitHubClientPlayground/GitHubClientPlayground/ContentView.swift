//
//  ContentView.swift
//  GitHubClientPlayground
//
//  Created by HIROKI IKEUCHI on 2022/03/29.
//

import SwiftUI

struct ContentView: View {
    
    private let mockTextInfoList = [
        TextInfo(id: 1, fontWeight: .light),
        TextInfo(id: 2, fontWeight: .regular),
        TextInfo(id: 3, fontWeight: .medium),
        TextInfo(id: 4, fontWeight: .bold),
        TextInfo(id: 5, fontWeight: .heavy),
    ]
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image("GitHubMark")
                    .resizable()
                    .frame(width: 44.0, height: 44.0)
                Text("Font samples")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
            
            List(mockTextInfoList) { textInfo in
                TextRowView(textInfo: textInfo)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
