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
        
        titleLabel.snp.makeConstraints { (make) in
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            make.centerX.equalTo(view.snp.centerX)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(textStack.snp.top).offset(-view.frame.height/10)
        }
        textStack.snp.makeConstraints { (make) in
            textStack.translatesAutoresizingMaskIntoConstraints = false
            textStack.distribution = .fillEqually
            textStack.spacing = view.frame.height / 40
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).multipliedBy(1.1)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        
        textView.frame = view.frame
        imageView.frame = view.frame
        for n in 0...(textLable.count-1){
            
            textLable[n].snp.makeConstraints { (make) in
                textLable[n].translatesAutoresizingMaskIntoConstraints = false
                textLable[n].textColor = .white
                make.left.right.equalTo(textStack).offset(3)
            }
        }
    }


}
