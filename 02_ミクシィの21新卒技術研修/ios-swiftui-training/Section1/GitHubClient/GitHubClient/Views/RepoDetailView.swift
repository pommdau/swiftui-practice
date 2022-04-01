//
//  RepoDetailView.swift
//  GitHubClient
//
//  Created by HIROKI IKEUCHI on 2022/03/02.
//

import SwiftUI

struct RepoDetailView: View {
    let repo: Repo
    
    var body: some View {
        
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("GitHubMark")
                            .resizable()
                            .frame(width: 16, height: 16)
                        Text(repo.owner.name)
                            .font(.caption)
                    }
                    
                    Text(repo.name)
                        .font(.body)
                        .fontWeight(.bold)
                    
                    if let description = repo.description {
                        Text(description)
                            .padding(.top, 4)
                    }
                    
                    HStack {
                        Image(systemName: "star")
                        Text("\(repo.stargazersCount) stars")
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.top, 30)
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct RepoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailView(repo: .mock1)
    }
}
