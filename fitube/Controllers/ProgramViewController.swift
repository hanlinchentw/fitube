//
//  ProgramViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/14.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {
    
    var segmentedController: UISegmentedControl!
    private var embedController: EmbedController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        
        
//        let codeSegement = CustomSegementedControl(frame: CGRect(x: 0, y: 0,
//        width: self.view.frame.width, height: 50), buttonTitle: ["Challenge","Motivation","others"])
//        codeSegement.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0.2850462148, alpha: 1)
//        view.addSubview(codeSegement)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        let selectedindex = codeSegement.bbuttonindex
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        // add child view controller view to container
        let controller = storyboard!.instantiateViewController(withIdentifier: "Other")
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        controller.didMove(toParent: self)
    }
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        view.addSubViews(menuBar)
    }
    
        
        
    
    


}
