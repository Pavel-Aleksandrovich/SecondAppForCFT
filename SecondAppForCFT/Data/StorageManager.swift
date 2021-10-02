//
//  StorageManager.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveNote(_ model: NoteEntity) {
        try! realm.write{
            realm.add(model)
        }
    }
    
    static func deleteNote(_ model: NoteEntity) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    static func updateNote(_ oldNote: NoteEntity, _ newNote: NoteEntity) {
        try! realm.write{
            oldNote.title = newNote.title
            oldNote.subTitle = newNote.subTitle
        }
    }
    
    static func getNotes() -> Results<NoteEntity> {
        return realm.objects(NoteEntity.self)
    }
}
