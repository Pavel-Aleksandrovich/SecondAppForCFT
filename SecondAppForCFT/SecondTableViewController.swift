//
//  SecondTableViewController.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import UIKit
import RealmSwift

class SecondTableViewController: UITableViewController {
    
    var currentNote: Model?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        titleTextField.addTarget(self, action: #selector(enableSaveButton), for: .editingChanged)
        editScreen()
        //        saveNote()
    }
    
    
    func saveNote() {
        let newNote = Model(title: titleTextField.text!, textOfNote: descriptionTextView.text)
        
        if currentNote != nil {
            try! realm.write{
                currentNote?.title = newNote.title
                currentNote?.textOfNote = newNote.textOfNote
            }
        } else {
            StorageManager.saveNote(newNote)
        }
        
    }
    
    @IBAction func cancelActionBackScreen(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func editScreen() {
        if currentNote != nil {
            editNavigationBar()
            
            titleTextField.text = currentNote?.title
            descriptionTextView.text = currentNote?.textOfNote
        }
    }
    private func editNavigationBar() {
        navigationItem.leftBarButtonItem = nil
        title = currentNote?.title
        saveButton.isEnabled = true
    }
}

extension SecondTableViewController: UITextFieldDelegate {
    
    @objc private func enableSaveButton(){
        if titleTextField.text?.isEmpty == true {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
    
    
}
