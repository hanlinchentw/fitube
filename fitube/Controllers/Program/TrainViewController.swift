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
        
        DispatchQueue.main.async {
            self.setupView()
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
extension TrainViewController{
    
    fileprivate func setupView(){
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        numofExercise = defaluts.integer(forKey:"currentExercise")
        print(numofExercise)
        if let exercise = trainingSection{
            exerciseLabel.text = exercise[numofExercise]
            exampleImage.image = UIImage(named: exercise[numofExercise])
        }
        
        exampleImage.snp.makeConstraints { (make) in
            exampleImage.translatesAutoresizingMaskIntoConstraints = false
            make.top.left.right.centerX.equalToSuperview()
        }
        exerciseLabel.snp.makeConstraints { (make) in
            exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
            exerciseLabel.font.withSize(40*view.frame.height/725)
            make.top.equalTo(exampleImage.snp.bottom).offset(view.frame.height/20)
            make.centerX.left.right.equalTo(view)
        }
        setProgress.snp.makeConstraints { (make) in
            setProgress.translatesAutoresizingMaskIntoConstraints = false
            setProgress.progress = 0
            make.top.equalTo(exerciseLabel.snp.bottom).offset(view.frame.height/40)
            make.centerX.equalTo(view)
            make.left.right.equalTo(view).offset(view.frame.width/10)
        }
        progressLabel.snp.makeConstraints { (make) in
            progressLabel.translatesAutoresizingMaskIntoConstraints = false
            make.top.equalTo(setProgress.snp.bottom).offset(view.frame.height/70)
            make.right.equalTo(setProgress)
        }
        remainingSet.snp.makeConstraints { (make) in
            remainingSet.translatesAutoresizingMaskIntoConstraints = false
            remainingSet.font.withSize(30*view.frame.height/725)
            make.top.equalTo(exerciseLabel.snp.bottom).offset(view.frame.height/10)
            make.centerX.equalToSuperview()
        }
        finishButton.snp.makeConstraints { (make) in
            finishButton.translatesAutoresizingMaskIntoConstraints = false
            finishButton.layer.cornerRadius = 20
            make.height.equalTo(view).multipliedBy(0.07)
            make.width.equalTo(view).multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(remainingSet.snp.bottom).offset(view.frame.height/100)
        }
        nextOneButton.snp.makeConstraints { (make) in
            nextOneButton.translatesAutoresizingMaskIntoConstraints = false
            make.bottom.equalTo(view).offset(-view.frame.height/20)
            make.centerX.equalToSuperview()
        }
    }
}

