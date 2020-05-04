//
//  ViewController.swift
//  LifeGoals
//
//  Created by Paul Colombier on 20/04/2020.
//  Copyright © 2020 Paul Colombier. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {
    
    let _goalManager = GoalManager()
    
    @IBOutlet weak var ui_newGoalTextField: UITextField!
    @IBOutlet weak var ui_goalsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ui_newGoalTextField.delegate = self
        ui_goalsTableView.dataSource = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let goalText = ui_newGoalTextField.text,
            let goalIndex = _goalManager.addGoal(withText: goalText) {
                ui_goalsTableView.insertRows(at: [IndexPath(row: goalIndex, section: 0)], with: .automatic)
            ui_newGoalTextField.text = nil
        }
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = nil
        textField.resignFirstResponder()
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _goalManager.getGoalCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goal-cell", for: indexPath)
        cell.textLabel?.text = _goalManager.getGoal(atIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        _goalManager.removeGoal(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

}

