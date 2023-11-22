//
//  Note.swift
//  NotesApp
//
//  Created by HIROKI IKEUCHI on 2023/11/22.
//

import Foundation
import SwiftData

@Model
class Note {
    var content: String
    var isFavorite: Bool = false
    var category: NoteCategory?
    
    init(content: String, category: NoteCategory? = nil) {
        self.content = content
        self.category = category
    }    
}
