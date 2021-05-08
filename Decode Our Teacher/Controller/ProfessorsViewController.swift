//
//  ProfessorsViewController.swift
//  Decode Our Teacher
//
//  Created by Katherine Yang on 4/23/21.
//

import UIKit
import Firebase
class ProfessorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var professors:[Professor] = [Professor(sender: "123@qq.com", professorName: "Andy Lee", rate: 7, difficulty: 4), Professor(sender: "1@23.com", professorName: "Jack Wang", rate: 9, difficulty: 8)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        title = "Decode Our Teacher"
        navigationItem.hidesBackButton = true
        
    }

    @IBAction func rateProfessor(_ sender: UIButton) {
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
}
extension ProfessorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        //give cell data
        cell.textLabel?.text = professors[indexPath.row].professorName
    
        return cell
    }
}

extension ProfessorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
