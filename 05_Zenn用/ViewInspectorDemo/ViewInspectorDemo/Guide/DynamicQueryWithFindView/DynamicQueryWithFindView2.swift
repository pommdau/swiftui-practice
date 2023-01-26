//
//  DynamicQueryWithFindView2.swift
//  ViewInspectorDemo
//
//  Created by Hiroki Ikeuchi on 2023/01/13.
//

import SwiftUI

struct DynamicQueryWithFindView2: View {
    var body: some View {
        VStack {
            HStack {
                Text("abc")
                    .font(.headline)
                Text("abc")
                Text("def")
            }
            
            List(Book.sampleData) { book in
                TableViewCell(book: book)
            }
        }
    }
}

struct DynamicQueryWithFindView2_Previews: PreviewProvider {
    static var previews: some View {
        DynamicQueryWithFindView2()
    }
}

// MARK: - TableViewCell

struct TableViewCell: View {
    
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
            Text(book.contents)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Book

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let contents: String
}

extension Book {
    static let sampleData: [Book] = [
        .init(title: "title1", contents: "title1 contents"),
        .init(title: "title2", contents: "title2 contents"),
    ]
}
