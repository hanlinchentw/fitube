//
//  FirstPageViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/20.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {

    @IBOutlet weak var welcomeStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSLayoutConstraint(item: welcomeStackView!, attribute: .centerX, relatedBy: .equal,
                           toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
       
        NSLayoutConstraint(item: welcomeStackView!, attribute: .centerY, relatedBy: .equal,
                           toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        
    }
    

}
