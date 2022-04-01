//
//  TextRowView.swift
//  GitHubClientPlayground
//
//  Created by HIROKI IKEUCHI on 2022/03/29.
//

import SwiftUI

struct TextRowView: View {
    let textInfo: TextInfo
    
    var body: some View {
        
        HStack {
            Image("GitHubMark")
                .resizable()
                .frame(width: 22.0, height: 22.0)
            Text("あのイーハトーヴォの透き通った風")
                .font(.system(size: textInfo.fontSize))
                .fontWeight(textInfo.fontWeight)
        }
    }
    
}

struct TextRowView_Previews: PreviewProvider {
    static var previews: some View {
        TextRowView(textInfo: TextInfo(id: 1, fontWeight: .regular))
    }
}
