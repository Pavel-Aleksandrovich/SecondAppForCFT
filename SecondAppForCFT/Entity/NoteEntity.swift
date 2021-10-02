//
//  Model.swift
//  SecondAppForCFT
//
//  Created by pavel mishanin on 30.09.2021.
//

import RealmSwift

class NoteEntity: Object {
    @objc dynamic var title: String?
    @objc dynamic var subTitle: String?
    
    convenience init(title: String?, subTitle: String?) {
        self.init()
        self.title = title
        self.subTitle = subTitle
    }
}
