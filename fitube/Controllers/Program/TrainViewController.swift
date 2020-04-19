//
//  TrainViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class TrainViewController: UIViewController {
    
    var trainingSection : [String]?
    var numofExercise = 1
    var numofSet = 4
    var lastSetRemaining = 4
    
    
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var remainingSet: UILabel!

    @IBOutlet weak var nextOneButton: UIButton!
    @IBOutlet weak var previousOneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        previousOneButton.isHidden = true
        if let exercise = trainingSection{
            exerciseLabel.text = exercise[1]
        }
    }
    var test = true
    override func viewDidAppear(_ animated: Bool) {
        if test {
            performSegue(withIdentifier:"trainStarted", sender: self)
            test = false
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trainStarted"{
            let destinationVC =  segue.destination as! PopUpViewController
            destinationVC.trainingNote = trainingSection
        }
    }

    @IBAction func previousOneButton(_ sender: UIButton) {
        numofExercise -= 1
        if numofExercise == 1 {
            sender.isHidden = true
        }else{
            sender.isHidden = false
        }
        if let exercise = trainingSection{
            exerciseLabel.text = exercise[numofExercise]
            remainingSet.text = "Remaining: \(lastSetRemaining) sets"
        }
    }
    
    
    @IBAction func nextOneButton(_ sender: UIButton) {
        numofExercise += 1
        if let exercise = trainingSection{
            if numofExercise >= exercise.count{
                dismiss(animated: true, completion: nil)
            }else{
                sender.isHidden = false
                previousOneButton.isHidden = false
                exerciseLabel.text = exercise[numofExercise]
                numofSet = 4
                remainingSet.text = "Remaining: \(numofSet) sets"
            }
            
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        if numofSet == 1 {
            previousOneButton.isHidden = false
            if let exercise = trainingSection{
                numofExercise += 1
                if numofExercise >= exercise.count{
                    dismiss(animated: true, completion: nil)
                }else{
                    exerciseLabel.text = exercise[numofExercise]
                }
            }
            numofSet = 4
            remainingSet.text = "Remaining: \(numofSet) sets"
        }else{
            
            numofSet -= 1
            remainingSet.text = "Remaining: \(numofSet) sets"
            lastSetRemaining = numofSet
            
        }
        
    }
    

}
