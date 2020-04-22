//
//  SecondPageViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/20.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController {

    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var textLable: [UILabel]!
    
    @IBOutlet weak var textStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textStack.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textStack.distribution = .fillEqually
        textStack.spacing = view.frame.height / 40
        
        NSLayoutConstraint(item: titleLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .bottom, relatedBy: .equal, toItem: textStack, attribute: .top, multiplier: 1, constant: -view.frame.height/10).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20).isActive = true
        
        NSLayoutConstraint(item: textStack!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: textStack!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.1, constant: 0).isActive = true
        NSLayoutConstraint(item: textStack!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: textStack!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 20).isActive = true
        
        
        textView.frame = view.frame
        imageView.frame = view.frame
        for n in 0...(textLable.count-1){
            textLable[n].translatesAutoresizingMaskIntoConstraints = false
            textLable[n].textColor = .white
            NSLayoutConstraint(item: textLable[n], attribute: .leading, relatedBy: .equal, toItem: textStack, attribute: .leading, multiplier: 1, constant: 3).isActive = true
            NSLayoutConstraint(item: textLable[n], attribute: .trailing, relatedBy: .equal, toItem: textStack, attribute: .trailing, multiplier: 1, constant: 3).isActive = true
        }
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
