//
//  TrainViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import ChameleonFramework
class TrainViewController: UIViewController {
    
    var trainingSection : [String]?
    var numofExercise = 1
    var numofSet = 1
    
    @IBOutlet weak var exampleImage: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var setProgress: UIProgressView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var remainingSet: UILabel!

    @IBOutlet weak var nextOneButton: UIButton!

    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        if let exercise = trainingSection{
            exerciseLabel.text = exercise[1]
            exampleImage.image = UIImage(named: exercise[1])
        }
        
        //MARK: -  Constraints
        exampleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: exampleImage!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: exampleImage!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: exampleImage!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: exampleImage!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
        
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        exerciseLabel.font.withSize(40*view.frame.height/725)
        NSLayoutConstraint(item: exerciseLabel!, attribute: .top, relatedBy: .equal, toItem: exampleImage, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: exerciseLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        setProgress.translatesAutoresizingMaskIntoConstraints = false
        setProgress.progress = 0
        NSLayoutConstraint(item: setProgress!, attribute: .top, relatedBy: .equal, toItem: exerciseLabel, attribute: .bottom, multiplier: 1, constant: view.frame.height/40).isActive = true
        NSLayoutConstraint(item: setProgress!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: setProgress!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/10).isActive = true
        NSLayoutConstraint(item: setProgress!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -view.frame.width/10).isActive = true
        
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: progressLabel!, attribute: .top, relatedBy: .equal, toItem: setProgress, attribute: .bottom, multiplier: 1, constant: view.frame.height/70).isActive = true
        NSLayoutConstraint(item: progressLabel!, attribute: .trailing, relatedBy: .equal, toItem: setProgress, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        
        remainingSet.translatesAutoresizingMaskIntoConstraints = false
        remainingSet.font.withSize(30*view.frame.height/725)
        NSLayoutConstraint(item: remainingSet!, attribute: .top, relatedBy: .equal, toItem: exerciseLabel, attribute: .bottom, multiplier: 1, constant: view.frame.height/10).isActive = true
        NSLayoutConstraint(item: remainingSet!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.layer.cornerRadius = 30
        NSLayoutConstraint(item: finishButton!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.07, constant: 0).isActive = true
        NSLayoutConstraint(item: finishButton!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: finishButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: finishButton!, attribute: .top, relatedBy: .equal, toItem: remainingSet, attribute: .bottom, multiplier: 1, constant: view.frame.height/100).isActive = true
        
        nextOneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: nextOneButton!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -view.frame.height/20).isActive = true
        NSLayoutConstraint(item: nextOneButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
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
        }else if segue.identifier == "rest"{
            let dVC = segue.destination as! RestViewController
            if numofExercise < trainingSection!.count{
                dVC.currentExercise = trainingSection![numofExercise]
                dVC.nextExercise = trainingSection![numofExercise+1]
                dVC.currentNumofSet = numofSet
            }
            
        }
    }

    @IBAction func nextOneButton(_ sender: UIButton) {
        numofExercise += 1
        if let exercise = trainingSection{
            if numofExercise >= exercise.count{
                dismiss(animated: true, completion: nil)
            }else{
                sender.isHidden = false
                exerciseLabel.text = exercise[numofExercise]
                exampleImage.image = UIImage(named: exercise[numofExercise])
                numofSet = 1
                remainingSet.text = "Set \(numofSet)"
                progressLabel.text = "1 / 4"
            }
            
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        if numofSet == 4 {
            if let exercise = trainingSection{
                numofExercise += 1
                if numofExercise >= exercise.count{
                    dismiss(animated: true, completion: nil)
                }else{
                    performSegue(withIdentifier: "rest", sender: self)
                    UIView.transition(with: setProgress, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.setProgress.progress = 0
                        self.progressLabel.text = "0 / 4"
                    })
                    exerciseLabel.text = exercise[numofExercise]
                    exampleImage.image = UIImage(named: exercise[numofExercise])
                }
            }
            
            numofSet = 1
            
        }else{
            performSegue(withIdentifier: "rest", sender: self)
            setProgress.progress = Float(numofSet)/4
            progressLabel.text = "\(numofSet) / 4"
            numofSet += 1
        }
        remainingSet.text = "Set \(numofSet)"
    }
    

}


