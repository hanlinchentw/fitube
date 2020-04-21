//
//  ListViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/21.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    
    var levelSend : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let safelevel = levelSend else {
            fatalError()
        }
        if let safeImage = UIImage(named: safelevel){
            ImageView.image = safeImage
        }
    }
    
}
