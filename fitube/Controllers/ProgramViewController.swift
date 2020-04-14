//
//  ProgramViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/14.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

protocol indexDelegate {
    func fetchindex(index:Int)
}

class ProgramViewController: UIViewController ,indexDelegate{

    func fetchindex(index:Int)  {
//        selectedindex = index
    }

    @IBOutlet weak var RcontainerView: UIView!
    @IBOutlet weak var GcontainerView: UIView!
    @IBOutlet weak var BcontainerView: UIView!
//
//    var selectedindex : Int = 0 {
//        didSet{
//            switch selectedindex {
//            case 0:
//                RcontainerView.isHidden = false
//                GcontainerView.isHidden = true
//                BcontainerView.isHidden = true
//            case 1:
//                RcontainerView.isHidden = true
//                GcontainerView.isHidden = false
//                BcontainerView.isHidden = true
//            case 2:
//                RcontainerView.isHidden = true
//                GcontainerView.isHidden = true
//                BcontainerView.isHidden = false
//            default:
//                return
//            }
//        }
//    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        RcontainerView.isHidden = false
        GcontainerView.isHidden = true
        BcontainerView.isHidden = true
        
        let codeSegement = CustomSegementedControl(frame: CGRect(x: 0, y: 0,
        width: self.view.frame.width, height: 50), buttonTitle: ["Challenge","Motivation","others"])
        codeSegement.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.2850462148, alpha: 1)
        view.addSubview(codeSegement)
        navigationController?.navigationBar.shadowImage = UIImage()
  
        view.backgroundColor = .white
    }

}
