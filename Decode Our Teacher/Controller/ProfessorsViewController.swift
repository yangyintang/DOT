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
    
    var professors:[Professor] = []
    
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        title = "Decode Our Teacher"
        navigationItem.hidesBackButton = true
        loadRate()
    }
    
    func loadRate() {
        //professors = []
        db.collection("rate").addSnapshotListener { (querySnapshot, error) in
            self.professors = []
            if let e = error {
                print ("The issue retrieving data from Firestore is \(e)")
            }else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments{
                        //print(doc.data())
                        let data = doc.data()
                        if let sender = data["sender"] as? String, let teacherName = data["teacher name"] as? String,
                           let comment = data["comment"]as? String, let rate = data["rate"] as? String, let difficulty = data["difficulty"]as? String{

                            let newProfessor = Professor(sender: sender, professorName: teacherName, rate: Int(rate)!, difficulty: Int(difficulty)!, comment: comment)
                            
                                self.professors.append(newProfessor)

                           DispatchQueue.main.async {
                                self.tableView.reloadData()
                           }
                        }
                        
                    }
                }
            }
        }
            
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
