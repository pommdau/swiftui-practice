//
//  ContentView.swift
//  TableViewDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/18.
//

import SwiftUI

struct ContentView: View {

    @State private var people = [
        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
    ]
    
    @State private var selectedPeople = Set<Person.ID>()

    var body: some View {
        VStack {
            Table(people, selection: $selectedPeople) {
                TableColumn("Given Name", value: \.givenName)
                TableColumn("Family Name", value: \.familyName)
                TableColumn("E-Mail Address", value: \.emailAddress)
            }
            .tableStyle(.bordered(alternatesRowBackgrounds: false))
            
            Divider()
                .padding(.bottom, 8)
            HStack {
                Button {
                    withAnimation {
                        people.append(Person(givenName: "NewPerson", familyName: "(New)", emailAddress: "(New)"))
                    }
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
