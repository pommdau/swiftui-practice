//
//  ContentView.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import SwiftUI

struct TweetListView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel: TweetListViewModel
        
    // MARK: - Lifecycles
    
    init(viewModel: TweetListViewModel = TweetListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Views
    
    var body: some View {
        
        NavigationView {
            Group {
                switch viewModel.tweets {
                case .idle, .loading:
                    ProgressView("loading...")
                case let .loaded(tweets):
                    if tweets.isEmpty {
                        Text("No tweets")
                    } else {
                        List(tweets) { tweet in
                            NavigationLink(
                                destination: TweetDetailView(tweet: tweet)) {
                                    TweetRow(tweet: tweet)
                                }
                        }
                    }
                case .failed:
                    VStack {
                        Group {
                            Image("GitHubMark")
                            Text("Failed to load repositories")
                                .padding(.top, 4)
                        }
                        .foregroundColor(.black)
                        .opacity(0.4)
                        Button(
                            action: {
                                viewModel.onRetryButtonTapped()
                            },
                            label: {
                                Text("Retry")
                                    .fontWeight(.bold)
                            }
                        )
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Tweets")
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TweetListView()
    }
}
