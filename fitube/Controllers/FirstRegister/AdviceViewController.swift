//
//  AdviceViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/22.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class AdviceViewController: UIViewController {


    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wuLongImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    var quotegenerate = NoteforUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        let quote = quotegenerate.notefromDeveloper()
        quoteLabel.text = quote
        
        
        //MARK: - Constraints
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        startButton.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.layer.cornerRadius = startButton.frame.height/3
        wuLongImage.frame = view.frame
        
        
        NSLayoutConstraint(item: quoteLabel!, attribute: .leading, relatedBy: .equal,
                           toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/70).isActive = true
        NSLayoutConstraint(item: quoteLabel!, attribute: .trailing, relatedBy: .equal,
                           toItem: view, attribute: .trailing, multiplier: 1, constant: -view.frame.width/70).isActive = true
        NSLayoutConstraint(item: quoteLabel!, attribute: .centerX, relatedBy: .equal,
                           toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: quoteLabel!, attribute: .centerY, relatedBy: .equal,
                           toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        quoteLabel.textAlignment = .center
    
        titleLabel.font.withSize(40*view.frame.height/725)
        NSLayoutConstraint(item: titleLabel!, attribute: .centerX, relatedBy: .equal,
                           toItem: quoteLabel, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .bottom, relatedBy: .equal,
                           toItem: quoteLabel, attribute: .top, multiplier: 1, constant: -view.frame.height/40).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .bottom, relatedBy: .equal,
        toItem: quoteLabel, attribute: .top, multiplier: 1, constant: view.frame.height/20).isActive = true

    
        startButton.titleLabel?.font.withSize(40*view.frame.height/725)
        NSLayoutConstraint(item: startButton!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive  = true
        NSLayoutConstraint(item: startButton!, attribute: .top, relatedBy: .equal, toItem: quoteLabel, attribute: .bottom, multiplier: 1, constant: view.frame.height/15).isActive = true


    }

}
