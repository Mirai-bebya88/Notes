//
//  NoteDetailsViewController.swift
//  Notes
//
//  Created by elene malakmadze on 27.11.25.
//

import UIKit

class NoteDetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var content: UITextView!
    
    var indexOfNote: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (indexOfNote != nil) {
            let note = NotesDataSource.shared.notesData[indexOfNote ?? 0]

            name.text = note.name
            content.text = note.content
        }
        
        setUpNavigationBarItem()
    }
    
    func setUpNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "checkmark.circle"),
            style: .prominent,
            target: self,
            action: #selector(handleSaveButtonTapped)
        )
    }
    
    @objc func handleSaveButtonTapped() {
        let newNote = Note(name: name.text ?? "", content: content.text ?? "")
        
        if (indexOfNote != nil) {
            NotesDataSource.shared.notesData[indexOfNote ?? 0] = newNote
        } else {
            NotesDataSource.shared.notesData.append(newNote)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
