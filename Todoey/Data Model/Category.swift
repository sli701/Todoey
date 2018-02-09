//
//  Category.swift
//  Todoey
//
//  Created by Shuntian Li on 2018-02-09.
//  Copyright © 2018 Shuntian Li. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
