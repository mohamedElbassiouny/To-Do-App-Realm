//
//  insertViewController.swift
//  ToDoApp-Realm
//
//  Created by Mohamed Elbassiouny on 7/27/19.
//  Copyright © 2019 Mohamed Elbassiouny. All rights reserved.
//

import UIKit
import RealmSwift
class insertViewController: UIViewController {
    
    var icomingTodo :ToDoData? = nil
    let realm = try! Realm()
    
    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var switchButton: UISwitch!
   
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if let goodToGo = icomingTodo{
            try! realm.write {
                goodToGo.isDone = switchButton.isOn
                goodToGo.toDoText = toDoTextField.text!
            }
            
        }else{
                let todo = ToDoData()
                todo.toDoText = toDoTextField.text!
                todo.isDone = switchButton.isOn
                
                try! realm.write {
                    realm.add(todo)
                }
        }
       
        navigationController?.popViewController(animated: true)
         print("Tapped")
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let goodToGo = icomingTodo{
                goodToGo.isDone = switchButton.isOn
                goodToGo.toDoText = toDoTextField.text!
            }
        // Do any additional setup after loading the view.
    }

}
