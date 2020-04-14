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
    
    @IBOutlet weak var subTilteLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    let isFirstOpenApp = UserDefaults.standard.bool(forKey: "isFirstOpenApp")
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:self.view.frame, andColors:[UIColor.white, UIColor.flatBlueDark()])
        startButton.layer.cornerRadius = 10
        navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.backgroundColor =  UIColor.white
        navigationController?.isNavigationBarHidden = false
    }
    
    

}

