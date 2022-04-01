//
//  TweetRow.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import SwiftUI

struct TweetRow: View {
    let tweet: Tweet
    
    var body: some View {        
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Image(tweet.user.icon)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    Text(tweet.user.userName)
                        .fontWeight(.bold)
                    Text(tweet.user.screenName)
                        .foregroundColor(.secondary)
                }
                
                Image(tweet.images.first!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
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
                .padding(.top, 8)
                .padding(.bottom, 8)
            }
        }
        .padding()
        
    }
}

struct TweetRow_Previews: PreviewProvider {
    static var previews: some View {
        TweetRow(tweet: .tweet1)
    }
}
