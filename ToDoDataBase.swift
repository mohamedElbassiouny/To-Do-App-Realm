//
//  ToDoDataBase.swift
//  ToDoApp-Realm
//
//  Created by Mohamed Elbassiouny on 7/29/19.
//  Copyright © 2019 Mohamed Elbassiouny. All rights reserved.
//

import Foundation
import RealmSwift
class ToDoData: Object{
    dynamic var isDoneTwxt = ""
    dynamic var toDoText = ""
}
