//
//  AdviceViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/22.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class AdviceViewController: UIViewController {

    @IBOutlet weak var textStack: UIStackView!
    @IBOutlet var textLabels: [UILabel]!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wuLongImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        startButton.translatesAutoresizingMaskIntoConstraints = false
        textStack.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.layer.cornerRadius = startButton.frame.height/3
        wuLongImage.frame = view.frame
        
        
        NSLayoutConstraint(item: textStack!, attribute: .leading, relatedBy: .equal,
                           toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/80).isActive = true
        NSLayoutConstraint(item: textStack!, attribute: .trailing, relatedBy: .equal,
                           toItem: view, attribute: .trailing, multiplier: 1, constant: -view.frame.width/80).isActive = true
        NSLayoutConstraint(item: textStack!, attribute: .centerX, relatedBy: .equal,
                           toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: textStack!, attribute: .bottom, relatedBy: .equal,
                           toItem: view, attribute: .bottom, multiplier: 1, constant: -(view.frame.height)/5).isActive = true

        
        textStack.alignment = .center
        textStack.distribution = .fillEqually
        textStack.spacing = view.frame.height/150
        
        NSLayoutConstraint(item: titleLabel!, attribute: .centerX, relatedBy: .equal,
                           toItem: textStack, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .bottom, relatedBy: .equal,
                           toItem: textStack, attribute: .top, multiplier: 1, constant: -view.frame.height/40).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .top, relatedBy: .equal,
        toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height/20).isActive = true

        for n in 0...(textLabels.count-1){
            textLabels[n].translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: textLabels[n], attribute: .leading, relatedBy: .equal,
                               toItem: textStack, attribute: .leading, multiplier: 1, constant: 3).isActive = true
            NSLayoutConstraint(item: textLabels[n], attribute: .trailing, relatedBy: .equal,
                               toItem: textStack, attribute: .trailing, multiplier: 1, constant: -3).isActive = true
        }
        
        NSLayoutConstraint(item: startButton!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive  = true
        NSLayoutConstraint(item: startButton!, attribute: .top, relatedBy: .equal, toItem: textStack, attribute: .bottom, multiplier: 1, constant: view.frame.height/15).isActive = true


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
