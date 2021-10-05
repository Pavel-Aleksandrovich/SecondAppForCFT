//
//  FirstTableViewController.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import UIKit
import RealmSwift

class ListOfNotesTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateTableView()
    }
    
    private var notes: Results<NoteEntity> = StorageManager.getNotes()
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteCell
        
        let note = notes[indexPath.row]
        cell.title.text = note.title
        
        return cell
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newNoteVC = segue.source as? NoteDetailsTableViewController else {return}
        newNoteVC.saveNote()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let note = notes[indexPath.row]
            let newNoteVC = segue.destination as! NoteDetailsTableViewController
            newNoteVC.currentNote = note
        }
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let note = notes[indexPath.row]
            StorageManager.deleteNote(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    // Creating an animation
    private func animateTableView() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.height
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: tableViewHeight, y: 0)
            
            UIView.animate(withDuration: 1.7, delay: delay*0.07, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {cell.transform = CGAffineTransform.identity})
            delay += 1
        }
    }
}
