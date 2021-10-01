//
//  StorageManager.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveNote(_ model: Model) {
        try! realm.write{
            realm.add(model)
        }
    }
    static func deleteObject(_ model: Model) {
        try! realm.write {
            realm.delete(model)
        }
    }
}

