//
//  ViewController.swift
//  ToDoApp-Realm
//
//  Created by Mohamed Elbassiouny on 7/27/19.
//  Copyright © 2019 Mohamed Elbassiouny. All rights reserved.
//

import UIKit
import RealmSwift

var todos : Results<ToDoData>!
var realm = try! Realm()

class ViewController: UIViewController{
    var currentIndex = 0
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        todos = realm.objects(ToDoData.self)
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        reload()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    

    
    func reload() {
        toDoTableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDelegate{}
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoTableViewCell
        let todo = todos[indexPath.row]
        cell.toDoLabel.text = todo.toDoText
        cell.isDoneLabel.text = todo.isDone ? "Done" : "Do It"
        return  cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(todos[indexPath.row])
            }
            reload()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "cellClick"{
//            let destination = segue.destination as! insertViewController
//            let todo = todos![toDoTableView.indexPathsForSelectedRows.row]
//            destination.icomingTodo = todo
//        }
//    }
//
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "cellClick", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? insertViewController {
            destination.icomingTodo = todos[currentIndex]
        }
    }
}
    



class ToDoData: Object{
    dynamic var isDone = false
    dynamic var toDoText = ""
}

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var isDoneLabel: UILabel!
}


