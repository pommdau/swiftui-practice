//
//  ContentView.swift
//  TableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/18.
//

import SwiftUI

struct ContentView: View {
    struct Person: Identifiable {
        let givenName: String
        let familyName: String
        let emailAddress: String
        let id = UUID()
    }
    private var people = [
        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
    ]

    var body: some View {
        VStack {
            Table(people) {
                TableColumn("Given Name", value: \.givenName)
                TableColumn("Family Name", value: \.familyName)
                TableColumn("E-Mail Address", value: \.emailAddress)
            }
            .tableStyle(.bordered(alternatesRowBackgrounds: false))
            
            Divider()
                .padding(.bottom, 8)
            HStack {
                Button {
                } label: {
                    Image(systemName: "plus")
                }
                .padding(.leading, 4)
                
                Button {
                } label: {
                    Image(systemName: "minus")
                }
                
                Spacer()
                
                Button {
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
