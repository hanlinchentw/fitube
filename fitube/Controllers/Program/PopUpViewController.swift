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
    var noteforUser = NoteforUser()
    
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        noteLabel.text = ""
        let notes = noteforUser.notefromDeveloper()
        for i in 0...(notes.count-1){
            noteLabel.text?.append("\(notes[i])\n")
        }
        exerciseLabel.text = ""
        if let exercise = trainingNote {
            for n in 1...(exercise.count-1){
                exerciseLabel.text?.append("\(n). \(exercise[n])\n")
            }
        }
        
        
    }

    @IBAction func headToBusinessButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

   

}