//
//  RestViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/23.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import AudioToolbox

class RestViewController: UIViewController {
    
    @IBOutlet weak var timeCounterLabel: UILabel!
    @IBOutlet weak var addTimeButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var formatter = DateFormatter()
    var timer =  Timer()
    var restTime = 60
    var timeEnd = Date(timeIntervalSinceNow:60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimeLeft), userInfo: nil, repeats: true)
        
        DispatchQueue.main.async {
            self.setupView()
        }
        
        
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
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            UIView.transition(with: timeCounterLabel,
                              duration: 0.2, options: .transitionCrossDissolve,
                              animations: {
                                self.timeCounterLabel.font.withSize(50)
                                self.timeCounterLabel.text = "Time's up!"
                                self.addTimeButton.isHidden = false
                                self.skipButton.isHidden = false
            })
            //            Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (_) in
            //                self.dismiss(animated: true, completion: nil)
            //            }
        }
    }
}
extension RestViewController{
    fileprivate func setupView(){
        
        titleLabel.snp.makeConstraints { (make) in
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            make.bottom.equalTo(view.snp.centerY).offset(-view.frame.height/5)
            make.centerX.equalTo(view)
        }
        timeCounterLabel.snp.makeConstraints { (make) in
            timeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview().offset(view.frame.height/30)
        }
        addTimeButton.snp.makeConstraints { (make) in
            addTimeButton.translatesAutoresizingMaskIntoConstraints = false
            addTimeButton.backgroundColor = #colorLiteral(red: 1, green: 0.9195527434, blue: 0, alpha: 1)
            addTimeButton.layer.cornerRadius = 15
            make.right.equalTo(view.snp.centerX).offset(-view.frame.height/20)
            make.left.equalTo(view.snp.left).offset(view.frame.width/10)
            make.top.equalTo(timeCounterLabel.snp.bottom).offset(view.frame.height/100)
        }
        skipButton.snp.makeConstraints { (make) in
            skipButton.translatesAutoresizingMaskIntoConstraints = false
            skipButton.backgroundColor = #colorLiteral(red: 0.5012164116, green: 0.9243927598, blue: 0.2496780753, alpha: 1)
            skipButton.layer.cornerRadius = 15
            make.left.equalTo(view.snp.centerX).offset(view.frame.height/20)
            make.top.equalTo(timeCounterLabel.snp.bottom).offset(view.frame.height/100)
            make.right.equalTo(view).offset(-view.frame.width/10)
        }
    }
}
