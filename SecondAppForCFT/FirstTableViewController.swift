//
//  FirstTableViewController.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import UIKit
import RealmSwift

class FirstTableViewController: UITableViewController {
    
    var notes: Results<Model>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = realm.objects(Model.self)
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.isEmpty ? 0 : notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let note = notes[indexPath.row]
        cell.titleFirstScreen.text = note.title
        
        return cell
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newNoteVC = segue.source as? SecondTableViewController else {return}
        newNoteVC.saveNote()
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let note = notes[indexPath.row]
            let newNoteVC = segue.destination as! SecondTableViewController
            newNoteVC.currentNote = note
        }
    }
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let note = notes[indexPath.row]
            StorageManager.deleteObject(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
}
