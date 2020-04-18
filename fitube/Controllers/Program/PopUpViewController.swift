//
//  PopUpViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/18.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    var trainingNote :[String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func headToBusinessButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier:"trainStarted", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trainStarted"{
            let destinationVC =  segue.destination as! TrainViewController
            destinationVC.trainingSection = trainingNote
        }
    }

   

}
