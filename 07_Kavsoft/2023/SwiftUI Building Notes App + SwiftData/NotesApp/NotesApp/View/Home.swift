//
//  Home.swift
//  NotesApp
//
//  Created by HIROKI IKEUCHI on 2023/11/22.
//

import SwiftUI
import SwiftData

struct Home: View {
    
    @State private var selectedTag: String? = "All Notes"
    @Query(animation: .snappy) private var categories: [NoteCategory]
    
    // Model Context
    @Environment(\.modelContext) private var context
    
    @State private var addCategory: Bool = false
    @State private var categoryTitle: String = ""
    @State private var requestedCategory: NoteCategory?
    @State private var deleteRequest: Bool = false
    @State private var renameRequest: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTag) {
                Text("All Notes")
                    .tag("All Notes")
                    .foregroundStyle(selectedTag == "All Notes" ? Color.primary : .gray)
                
                Text("Favorites")
                    .tag("Favorites")
                    .foregroundStyle(selectedTag == "Favorites" ? Color.primary : .gray)
                
                // User Created Categories
                Section {
                    ForEach(categories) { category in
                        Text(category.categoryTitle)
                            .tag(category.categoryTitle)
                            .foregroundStyle(selectedTag == category.categoryTitle ? Color.primary : .gray)
                        // some basic editing options
                            .contextMenu {
                                Button("Rename") {
                                    categoryTitle = category.categoryTitle
                                    requestedCategory = category
                                    renameRequest = true
                                }
                                
                                Button("Delete") {
                                    categoryTitle = category.categoryTitle
                                    requestedCategory = category
                                    deleteRequest = true
                                }
                            }
                    }
                } header: {
                    HStack(spacing: 5) {
                        Text("Categories")
                        Button("", systemImage: "plus") {
                            addCategory.toggle()
                        }
                        .tint(.gray)
                        .buttonStyle(.plain)
                    }
                }
                
            }
        } detail: {
            
        }
        .navigationTitle(selectedTag ?? "Notes")
        .alert("Add Category", isPresented: $addCategory) {
            TextField("Work", text: $categoryTitle)
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
            }
            
            Button("Add") {
                let category = NoteCategory(categoryTitle: categoryTitle)
                context.insert(category)
                categoryTitle = ""
            }
        }
        
        .alert("Rename Category", isPresented: $renameRequest) {
            TextField("Work", text: $categoryTitle)
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            
            Button("Rename") {
                if let requestedCategory {
                    requestedCategory.categoryTitle = categoryTitle
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
            }
        }
        
        .alert("Are you sure to delete \(categoryTitle) category?", isPresented: $deleteRequest) {
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            
            Button("Delete", role: .destructive) {
                if let requestedCategory {
                    context.delete(requestedCategory)
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
