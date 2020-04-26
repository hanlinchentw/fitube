//
//  WarmupViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class WarmupViewController: UIViewController {
    
    @IBOutlet weak var timeCounterLabel: UILabel!
    @IBOutlet weak var runningPic: UIImageView!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    var tenmins = 600.0
    var timeEnd = Date(timeIntervalSinceNow:600)
    var formatter = DateFormatter()
    var timer =  Timer()
    var isPaused = true
    var saveTime = "10 : 00"
    
    let defaults = UserDefaults.standard
    
    
    var delegate : sentBackData?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        tenmins = defaults.double(forKey: "timeRemaining")
        timeEnd = Date(timeIntervalSinceNow: defaults.double(forKey: "timeRemaining"))
        
        runningPic.translatesAutoresizingMaskIntoConstraints = false
        runningPic.layer.borderWidth = 3
        runningPic.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        NSLayoutConstraint(item: runningPic!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: runningPic!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: runningPic!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: runningPic!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: view.frame.height/10).isActive = true
       
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: playButton!, attribute: .top, relatedBy: .equal, toItem: runningPic, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: playButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        timeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        timeCounterLabel.layer.borderWidth = 3
        timeCounterLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        timeCounterLabel.layer.backgroundColor = #colorLiteral(red: 0.2851659656, green: 0.4760053754, blue: 0.7123829722, alpha: 1)
        timeCounterLabel.layer.cornerRadius = 10
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.6, constant: 0).isActive  = true
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .top, relatedBy: .equal, toItem: playButton, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: timeCounterLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true

        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: skipButton!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -view.frame.height/10).isActive = true

        NSLayoutConstraint(item: skipButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
    }
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    @available(iOS 13.0, *)
    @IBAction func playandPauseButtonPressed(_ sender: UIButton) {
        setView(view: timeCounterLabel, hidden: false)
        setView(view: skipButton, hidden: false)
        if isPaused{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTimeLeft), userInfo: nil, repeats: true)
            isPaused = false
            sender.setTitle("  Pause", for: .normal)
            sender.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.03486464173, alpha: 1)
        }else{
            timer.invalidate()
            isPaused = true
            sender.setTitle("  Continue", for: .normal)
            sender.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            sender.tintColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        }
        
    }
    @IBAction func nextOneButtonPressed(_ sender: UIButton) {
        
        timer.invalidate()
        isPaused = true
        playButton.setTitle("  Continue", for: .normal)
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        playButton.tintColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        
        let alert = UIAlertController(title: "Skip", message: "Are you sure to skip?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Yes", style: .default) { (sureAction) in
            self.defaults.set(self.tenmins, forKey: "timeRemaining")
            
            self.delegate?.dismissBack(sendData: "Remaining:  \(self.timeCounterLabel.text!)\n\nClick to continue")
            self.dismiss(animated: true, completion: nil)
        }
    
        
        let action2 = UIAlertAction(title: "No", style: .default) { (continueAction) in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setTimeLeft), userInfo: nil, repeats: true)
            self.isPaused = false
            self.playButton.setTitle("  Pause", for: .normal)
            self.playButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            self.playButton.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.03486464173, alpha: 1)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func setTimeLeft() {
        tenmins -= 1
    let timeNow = Date()
        timeEnd = Date(timeIntervalSinceNow: TimeInterval(tenmins))
    formatter.dateFormat = "mm:ss a"
    // Only keep counting if timeEnd is bigger than timeNow
        if timeEnd.compare(timeNow) == ComparisonResult.orderedDescending {
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.month,.day,.hour,.minute, .second], from: timeNow, to: timeEnd)
            if components.second! < 10{
                UIView.transition(with: timeCounterLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.timeCounterLabel.text = "0"+String(components.minute!) + ":0" + String(components.second!)
                }, completion: nil)
                
            }else{
                UIView.transition(with: timeCounterLabel, duration: 0.1, options: .transitionCrossDissolve, animations: {
                    self.timeCounterLabel.text = "0"+String(components.minute!) + ":" + String(components.second!)
                }, completion: nil)
            }
            

        } else {
            defaults.set(600.0, forKey: "timeRemaining")
            setView(view: playButton, hidden: true)
            
            UIView.transition(with: timeCounterLabel,
                              duration: 0.2, options: .transitionCrossDissolve,
                              animations: {
                self.timeCounterLabel.text = "Good job!"
            })
            UIView.transition(with: skipButton,
                              duration: 0.2, options: .transitionCrossDissolve,
                              animations: {
                self.skipButton.setTitle("Continue", for: .normal)
            })
            skipButton.removeTarget(self, action: #selector(self.nextOneButtonPressed(_:)), for: .touchUpInside)
            skipButton.addTarget(self, action: #selector(self.continueClick(sender:)), for: .touchUpInside)
        }

    }
    @objc func continueClick(sender:UIButton){
        delegate?.dismissBack(sendData: "   Finished!")
        dismiss(animated: true, completion: nil)
    }
}

extension String {
    func convertToTimeInterval() -> TimeInterval {
        guard self != "" else {
            return 0
        }
        var interval:Double = 0

        let parts = self.components(separatedBy: " : ")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
    }
}
