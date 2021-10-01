//
//  Model.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import RealmSwift

class Model: Object {
    @objc dynamic var title: String?
    @objc dynamic var textOfNote: String?
    
    convenience  init(title: String?, textOfNote: String?) {
        self.init()
        self.title = title
        self.textOfNote = textOfNote
    }
}
