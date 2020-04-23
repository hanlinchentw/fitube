//
//  RestViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/23.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class RestViewController: UIViewController {

    @IBOutlet weak var timeCounterLabel: UILabel!
    @IBOutlet weak var restImage: UIImageView!
    @IBOutlet weak var addTimeButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var formatter = DateFormatter()
    var timer =  Timer()
    var restTime = 60
    var timeEnd = Date(timeIntervalSinceNow:60)
    
    var currentExercise : String?
    var nextExercise : String?
    var currentNumofSet : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentNumofSet == 4{
            timeCounterLabel.text = "Good job!\nNext exercise:\n \(nextExercise!)"
            addTimeButton.isHidden = true
            skipButton.isHidden = true
            restImage.image = UIImage(named: "\(nextExercise!)")
            
            NSLayoutConstraint(item: restImage!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height/30).isActive = true
            NSLayoutConstraint(item: restImage!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: restImage!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: restImage!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        }else{
            timeCounterLabel.text = "1 : 00"
            addTimeButton.isHidden = false
            skipButton.isHidden = false
            restImage.image = UIImage(named: "rest2")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimeLeft), userInfo: nil, repeats: true)
            NSLayoutConstraint(item: restImage!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height/30).isActive = true
            NSLayoutConstraint(item: restImage!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: restImage!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: restImage!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: view.frame.height/5).isActive = true
        }
        
        
        //MARK: - Constraints
        restImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        timeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .top, relatedBy: .equal, toItem: restImage, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .trailing, relatedBy: .equal, toItem: restImage, attribute: .trailing, multiplier: 1, constant: -view.frame.height/20).isActive = true
        
        addTimeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: addTimeButton!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: -view.frame.height/20).isActive = true
        NSLayoutConstraint(item: addTimeButton!, attribute: .top, relatedBy: .equal, toItem: timeCounterLabel, attribute: .bottom, multiplier: 1, constant: view.frame.height/100).isActive = true
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: skipButton!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: skipButton!, attribute: .top, relatedBy: .equal, toItem: timeCounterLabel, attribute: .bottom, multiplier: 1, constant: view.frame.height/100).isActive = true
        
    }
    @IBAction func addTimeButtonPressed(_ sender: UIButton) {
        restTime += 15
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

    @objc func setTimeLeft() {
    let timeNow = Date()
    restTime -= 1
    timeEnd = Date(timeIntervalSinceNow:TimeInterval(restTime))
    formatter.dateFormat = "mm:ss a"
    // Only keep counting if timeEnd is bigger than timeNow
        if timeEnd.compare(timeNow) == ComparisonResult.orderedDescending {
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.month,.day,.hour,.minute, .second], from: timeNow, to: timeEnd)
            if components.second! < 10{
                UIView.transition(with: timeCounterLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.timeCounterLabel.text = String(components.minute!) + " : 0" + String(components.second!)
                }, completion: nil)
                
            }else{
                UIView.transition(with: timeCounterLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.timeCounterLabel.text = String(components.minute!) + " : " + String(components.second!)
                }, completion: nil)
            }
            

        } else {
            UIView.transition(with: timeCounterLabel,
                              duration: 0.2, options: .transitionCrossDissolve,
                              animations: {
                self.timeCounterLabel.text = "Good job!"
            })
            UIView.transition(with: addTimeButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.addTimeButton.isHidden = true
            })
            UIView.transition(with: skipButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.skipButton.isHidden = true
            })
        }
    }
}
