//
//  SecondTableViewController.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import UIKit
import RealmSwift

class NoteDetailsTableViewController: UITableViewController {
    
    // Call in class ListOfNotesTableViewController
    var currentNote: NoteEntity?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subTitleTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(enableSaveButton), for: .editingChanged)
        setNoteDetails(currentNote)
    }
    
    // Call in class ListOfNotesTableViewController
    func saveNote() {
        let newNote = NoteEntity(title: titleTextField.text, subTitle: subTitleTextView.text)
        if currentNote != nil {
            StorageManager.updateNote(currentNote!, newNote)
        } else {
            StorageManager.saveNote(newNote)
        }
    }
    
    @IBAction func cancelActionBackScreen(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setNoteDetails(_ note: NoteEntity?) {
        if note == nil {
            showNewNoteNavigationBar()
        }else{
            showEditNoteNavigationBar(note!)
        }
        
        titleTextField.text = note?.title ?? ""
        subTitleTextView.text = note?.subTitle ?? "SubTitle"
    }
    
    private func showNewNoteNavigationBar(){
        title = ""
        saveButton.isEnabled = false
    }
    
    private func showEditNoteNavigationBar(_ note: NoteEntity) {
        navigationItem.leftBarButtonItem = nil
        title = note.title
        saveButton.isEnabled = true
    }
}

extension NoteDetailsTableViewController: UITextFieldDelegate {
    
    @objc private func enableSaveButton(){
        if titleTextField.text?.isEmpty == true {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}
