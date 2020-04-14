//
//  CustomSegementedControl.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/14.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class CustomSegementedControl: UIView {
    private var buttonTitles : [String]!
    private var buttons : [UIButton]!
    private var selectorView : UIView!
    
    
    func configstackView(){
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo:
                                    self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo:
                                    self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo:
                                    self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo:
                                    self.rightAnchor).isActive = true
    }
    func configSelectorView(){
        let selectorWidth = (frame.width) / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 5))
        selectorView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        addSubview(selectorView)
    }
    func createButton(){
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach {$0.removeFromSuperview()}
        for buttonTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(self.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(UIColor.white, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(.white, for: .normal)
    }
    var bbuttonindex  = 0
    @objc func buttonAction(sender:UIButton){
        for (buttonindex, btn) in buttons.enumerated(){
            btn.setTitleColor(.white, for: .normal)
            if btn == sender{
                bbuttonindex = buttonindex
                let selectorPosition = (frame.width) / CGFloat(self.buttonTitles.count) * CGFloat(buttonindex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(.white, for: .normal)
            }
        }
    }
    func updateView(){
        createButton()
        configstackView()
        configSelectorView()
    }
    
    convenience init(frame: CGRect, buttonTitle : [String]) {
        self.init(frame : frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    func setButtonTitle(buttonTitles: [String]){
        self.buttonTitles = buttonTitles
        updateView()
    }
}
