//
//  NotesView.swift
//  NotesApp
//
//  Created by HIROKI IKEUCHI on 2023/11/22.
//

import SwiftUI
import SwiftData

struct NotesView: View {
    
    var category: String?
    var allCategories: [NoteCategory]
    
    @Query private var notes: [Note]
    
    init(category: String? = nil, allCategories: [NoteCategory]) {
        self.category = category
        self.allCategories = allCategories
        // Dynamic filtering
        let predicate = #Predicate<Note> {
            return $0.category?.categoryTitle == category
        }
        
        let favoritePrediacte = #Predicate<Note> {
            return $0.isFavorite
        }
        
        let finalPredicate = category == "All Notes" ?
        nil :
        (category == "Favorites" ? favoritePrediacte : predicate)
        
        _notes = Query(filter: finalPredicate, sort: [], animation: .snappy)
    }
    
    // MARK: View Properties
    
    @FocusState private var isKeyboardEnabled: Bool
    
    // model context
    @Environment(\.modelContext) private var context
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let width = size.width
            // Dynamic Grid Count based on the available size
            let rowCount = max(Int(width / 250), 1)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: rowCount), spacing: 10) {
                    ForEach(notes) { note in
                        NoteCardView(note: note, isKeyboardEnabled: $isKeyboardEnabled)
                            .contextMenu {
                                Button(note.isFavorite ? "Remove from Favorites" : "Move to Favorites") {
                                    note.isFavorite.toggle()
                                }
                                
                                Menu {
                                    ForEach(allCategories) { category in
                                        Button {
                                            // updating category
                                            note.category = category
                                        } label: {
                                            HStack(spacing: 5) {
                                                if category == note.category {
                                                    Image(systemName: "checkmark")
                                                        .font(.caption)
                                                }
                                                Text(category.categoryTitle)
                                            }
                                        }
                                    }
                                    Button("Remove from Categories") {
                                        note.category = nil
                                    }
                                } label: {
                                    Text("Category")
                                }
                                
                                Button("Delete", role: .destructive) {
                                    context.delete(note)
                                }
                                
                            }
                    }
                }
                .padding(12)
            }
            // Closing TextField when tapped outside
            .onTapGesture {
                isKeyboardEnabled = false
            }
        }
    }
}

// Note card view
// with editable textfield

struct NoteCardView: View {
    
    @Bindable var note: Note
    var isKeyboardEnabled: FocusState<Bool>.Binding
    @State private var showNote: Bool = false  // バグに対応するためらしい
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
            if showNote {
                TextEditor(text: $note.content)
                    .focused(isKeyboardEnabled)
                // custom hint
                    .overlay(alignment: .leading) {
                        Text("Finish Work")
                            .foregroundStyle(.gray)
                            .padding(.leading, 5)
                            .opacity(note.content.isEmpty ? 1 : 0)
                            .allowsHitTesting(false)
                    }
                    .scrollContentBackground(.hidden)
                    .multilineTextAlignment(.leading)
                    .padding(15)
                    .kerning(1.2)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.15), in: .rect(cornerRadius: 12))
            }
        }
        .onAppear {
            showNote = true
        }
        .onDisappear {
            showNote = false
        }
    }
}


//#Preview {
//    NotesView()
//}
