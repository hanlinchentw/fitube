//
//  RegisterViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/12.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var safeEmail : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let newEmail = emailTextField.text, let newPass = passwordTextField.text{
//            Auth.auth().createUser(withEmail: newEmail, password: newPass) { (authResult, error) in
//                if let e = error{
//                    print("Register's error: \(e)")
//                }else{
                    performSegue(withIdentifier: "registerDetail", sender: self)
                    safeEmail = newEmail
//                }
//            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? UserDataController
        destinationVC!.userEmail = safeEmail!
    }
}
