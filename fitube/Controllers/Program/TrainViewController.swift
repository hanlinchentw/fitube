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
    
    var delegate : lastExercise?
    let defaluts = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        numofExercise = defaluts.integer(forKey:"currentExercise")
        print(numofExercise)
        if let exercise = trainingSection{
            exerciseLabel.text = exercise[numofExercise]
            exampleImage.image = UIImage(named: exercise[numofExercise])
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
        finishButton.layer.cornerRadius = 20
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
        }    }
    
    @IBAction func BackToProgram(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Leave", message: "Do you want to save or reset?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Save", style: .default) { (_) in
            if let exercise = self.trainingSection{
                self.defaluts.set(self.numofExercise, forKey:"currentExercise")
                self.delegate?.trainingStaus(status: Float(self.numofExercise)/Float(exercise.count))
                self.navigationController?.popViewController(animated: true)
            }
        }
        let action2 = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.defaluts.set(1, forKey:"currentExercise")
            self.delegate?.trainingStaus(status: 0)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func nextOneButton(_ sender: UIButton) {
        numofExercise += 1
        if let exercise = trainingSection{
            if numofExercise >= exercise.count{
                self.defaluts.set(1, forKey:"currentExercise")
                delegate?.trainingStaus(status:1)
                self.navigationController?.popViewController(animated: true)
            }else{
                numofSet = 1
                exerciseLabel.text = exercise[numofExercise]
                exampleImage.image = UIImage(named: exercise[numofExercise])
                remainingSet.text = "Set \(numofSet)"
                setProgress.progress = 0
                progressLabel.text = "0 / 4"
            }
            
        }
    }
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        if numofSet == 4, setProgress.progress != 1{
            if let exercise = trainingSection{
                numofExercise += 1
                self.defaluts.set(self.numofExercise, forKey:"currentExercise")
                if numofExercise >= exercise.count{
                    self.defaluts.set(1, forKey:"currentExercise")
                    delegate?.trainingStaus(status:1)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    DispatchQueue.main.async {
                        UIView.transition(with: self.setProgress, duration: 1, options: .transitionCrossDissolve, animations: {
                            self.setProgress.progress = 1
                            self.progressLabel.text = "4 / 4"
                            self.exerciseLabel.text = "Good job!"
                            self.finishButton.isHidden = true
                            self.nextOneButton.isHidden = true
                            self.remainingSet.text = "Next exercise: \(exercise[self.numofExercise])"
                        })
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                            UIView.transition(with: self.setProgress, duration: 2, options: .transitionCrossDissolve, animations: {
                                self.setProgress.progress = 0
                                self.progressLabel.text = "0 / 4"
                                self.finishButton.isHidden = false
                                self.nextOneButton.isHidden = false
                                self.exerciseLabel.text = exercise[self.numofExercise]
                                self.exampleImage.image = UIImage(named: exercise[self.numofExercise])
                                self.remainingSet.text = "Set 1"
                            })
                            self.numofSet = 1
                        }
                    }
                }
            }
        }else{
            performSegue(withIdentifier: "rest", sender: self)
            setProgress.progress = Float(numofSet)/4
            progressLabel.text = "\(numofSet) / 4"
            numofSet += 1
        }
        remainingSet.text = "Set \(numofSet)"
    }
}


