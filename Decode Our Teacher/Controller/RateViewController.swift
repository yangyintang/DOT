//
//  RateViewController.swift
//  Decode Our Teacher
//
//  Created by Katherine Yang on 4/23/21.
//

import UIKit
import Firebase

class RateViewController: UIViewController {
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var commentTextfield: UITextField!
    @IBOutlet weak var teacherNameTextfield: UITextField!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    
    @IBAction func rateSliderChanged(_ sender: UISlider) {
        rateLabel.text = String(format: "%.0f", sender.value)
    }
    
    
    @IBAction func difficultySliderChanged(_ sender: UISlider) {
        difficultyLabel.text = String(format: "%.0f", sender.value)
    }
    
    
}
