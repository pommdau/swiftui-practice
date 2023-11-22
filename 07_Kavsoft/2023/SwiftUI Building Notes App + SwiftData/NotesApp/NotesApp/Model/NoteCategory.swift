//
//  NoteCategory.swift
//  NotesApp
//
//  Created by HIROKI IKEUCHI on 2023/11/22.
//

import Foundation
import SwiftData

@Model
class NoteCategory {
    var categoryTitle: String
    /// Relationship
    @Relationship(deleteRule: .cascade, inverse: \Note.category)
    var notes: [Note]?
    
    init(categoryTitle: String) {
        self.categoryTitle = categoryTitle
    }    
}
