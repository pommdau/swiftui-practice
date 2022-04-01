//
//  TweetDetailView.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import SwiftUI


struct TweetDetailView: View {
    let tweet: Tweet
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                Image(tweet.user.icon)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Text(tweet.user.userName)
                            .fontWeight(.bold)
                        Text(tweet.user.screenName)
                            .foregroundColor(.secondary)
                    }
                    Text(tweet.text)
                    
                    Image(tweet.images.first!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    HStack(spacing: 2) {
                        Button {
                            print("handle replyCount")
                        } label: {
                            Image(systemName: "bubble.left")
                                .foregroundColor(.primary)
                        }
                        Text("\(tweet.replyCount)")
                            .padding(.trailing, 8)
                        
                        Button {
                            print("handle retweetedCount")
                        } label: {
                            Image(systemName: "arrow.2.squarepath")
                                .foregroundColor(.primary)
                        }
                        Text("\(tweet.retweetedCount)")
                            .padding(.trailing, 8)
                        
                        Button {
                            print("handle reply")
                        } label: {
                            Image(systemName: "heart")
                                .foregroundColor(.primary)
                        }
                        Text("\(tweet.favoritedCount)")
                            .padding(.trailing, 8)
                        
                        Button {
                            print("handle reply")
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.primary)
                        }
                        
                    }
                }
            }
            .padding(8)
            .padding(.trailing, 12)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TweetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TweetDetailView(tweet: .tweet1)
    }
}
