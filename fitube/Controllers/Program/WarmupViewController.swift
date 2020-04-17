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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
        
    }
    @IBAction func nextOneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func setTimeLeft() {
    let timeNow = Date()

    // Only keep counting if timeEnd is bigger than timeNow
        if timeEnd.compare(timeNow) == ComparisonResult.orderedDescending {
            let calendar = NSCalendar.current
            let components = calendar.dateComponents([.minute, .second], from: timeNow, to: timeEnd)
            timeCounterLabel.text = String(components.minute!) + " : " + String(components.second!)

        } else {
            timeCounterLabel.text = "Ended"
        }

    }
}
