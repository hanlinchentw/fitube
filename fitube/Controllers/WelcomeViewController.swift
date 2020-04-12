//
//  ViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/12.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import ChameleonFramework
class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var subTilteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:self.view.frame, andColors:[UIColor.white, UIColor.flatBlueDark()])
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        logInButton.layer.cornerRadius = 10.0
        registerButton.layer.cornerRadius = 10.0
        let subtitle = "Be the Inspiration!"
        var index = 0.0
        for text in subtitle{
            let timer = Timer()
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) { (timer) in
                self.subTilteLabel.text?.append(text)
                
            }
            index += 1
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }


}

