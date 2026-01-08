//
//  NotesViewModel.swift
//  Notes
//
//  Created by elene malakmadze on 08.01.26.
//

import Foundation

protocol NotesViewModelProtocol {
    var refreshUI: (() -> ())? { get set }
    var notes: [Note] { get }
    func loadNotes()
    func filterNotes(with text: String)
    func getOriginalIndex(for note: Note) -> Int?
}

class NotesViewModel: NotesViewModelProtocol {
    
    var refreshUI: (() -> ())?
    
    private(set) var notes: [Note] = [] {
        didSet {
            refreshUI?()
        }
    }
    
    func loadNotes() {
        notes = NotesDataSource.shared.notesData
    }
    
    func filterNotes(with text: String) {
        if text.isEmpty {
            notes = NotesDataSource.shared.notesData
        } else {
            notes = NotesDataSource.shared.notesData.filter {
                $0.name.lowercased().contains(text.lowercased()) ||
                $0.content.lowercased().contains(text.lowercased())
            }
        }
    }
    
    func getOriginalIndex(for note: Note) -> Int? {
        NotesDataSource.shared.notesData.firstIndex(where: {
            $0.name == note.name && $0.content == note.content
        })
    }
}
