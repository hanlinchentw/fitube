//
//  WarmupViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class WarmupViewController: UIViewController {
    
    @IBOutlet weak var timeCounterLabel: UILabel!
    
    let timeEnd = Date(timeInterval: 10*60, since: Date())
    var formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
         Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTimeLeft), userInfo: nil, repeats: true)
    }
    @IBAction func nextOneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @objc func setTimeLeft() {
    let timeNow = Date()
    formatter.dateFormat = "mm:ss a"
    // Only keep counting if timeEnd is bigger than timeNow
        if timeEnd.compare(timeNow) == ComparisonResult.orderedDescending {
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.month,.day,.hour,.minute, .second], from: timeNow, to: timeEnd)
            if components.second! <= 10{
                timeCounterLabel.text = String(components.minute!) + " : 0" + String(components.second!)
            }else{
                timeCounterLabel.text = String(components.minute!) + " : " + String(components.second!)
            }
            

        } else {
            timeCounterLabel.text = "Ended"
        }

    }
}
