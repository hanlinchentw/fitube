//
//  ReportViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/15.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos



@available(iOS 13.0, *)
class ReportViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var goalLabel: UIStackView!
    @IBOutlet weak var videoGeneratorButton: UIStackView!
    @IBOutlet weak var finishedDay: UILabel!
    @IBOutlet var dayButtonCollection: [UIButton]!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var buttonStatck: UIStackView!
    
    let defaults = UserDefaults.standard
    
    private var photoArray :[String] = []
    var imageArray : [UIImage] = []
    
    var imageChoose = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: goalLabel!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height/30).isActive = true
        NSLayoutConstraint(item: goalLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.height/50).isActive = true
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = 20
        borderView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        borderView.layer.borderWidth = 5
        NSLayoutConstraint(item: borderView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: borderView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: borderView!, attribute: .top, relatedBy: .equal, toItem: goalLabel, attribute: .bottom, multiplier: 1, constant: view.frame.height/70).isActive = true
        NSLayoutConstraint(item: borderView!, attribute: .bottom, relatedBy: .equal, toItem: dayButtonCollection[29], attribute: .bottom, multiplier: 1, constant:view.frame.height/70).isActive = true
        
        buttonStatck.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: buttonStatck!, attribute: .top, relatedBy: .equal, toItem: borderView, attribute: .top, multiplier: 1, constant: view.frame.height/80).isActive = true
        NSLayoutConstraint(item: buttonStatck!, attribute: .leading, relatedBy: .equal, toItem: borderView, attribute: .leading, multiplier: 1, constant: view.frame.height/80).isActive = true
        NSLayoutConstraint(item: buttonStatck!, attribute: .trailing, relatedBy: .equal, toItem: borderView, attribute: .trailing, multiplier: 1, constant: view.frame.height/80).isActive = true
   
 
        
        videoGeneratorButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.layer.cornerRadius = 10
        NSLayoutConstraint(item: generateButton!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.07, constant: 0).isActive = true
        NSLayoutConstraint(item: videoGeneratorButton!, attribute: .top, relatedBy: .equal, toItem: borderView, attribute: .bottom, multiplier: 1, constant: view.frame.height/10).isActive = true
        NSLayoutConstraint(item: videoGeneratorButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
//        for n in 0...29{
//            dayButtonCollection[n].setBackgroundImage(UIImage(systemName:"\(n+1).square"), for: .normal)
//            dayButtonCollection[n].isUserInteractionEnabled = false
//            NSLayoutConstraint(item: dayButtonCollection[n], attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1/8, constant: 0).isActive = true
//            NSLayoutConstraint(item: dayButtonCollection[n], attribute: .width, relatedBy: .equal, toItem:dayButtonCollection[n] , attribute: .height, multiplier: 1, constant: 0).isActive = true
//        }
        let dayPassed = defaults.integer(forKey: "passedDay")
        finishedDay.text = String(dayPassed)
        
        
        generateButton.layer.cornerRadius = 10
        
       
            if dayPassed == 30{
//                generateButton.isUserInteractionEnabled = true
            }else if dayPassed == 0{
//                generateButton.isUserInteractionEnabled = false
            }else{
                for n in 0...dayPassed-1{
                    dayButtonCollection[n].setBackgroundImage(UIImage(systemName:"\(n+1).square.fill"), for: .normal)
                    dayButtonCollection[n].tintColor = #colorLiteral(red: 0, green: 0.5704279542, blue: 0.3237726688, alpha: 1)
                    dayButtonCollection[n].tag = n
                    dayButtonCollection[n].isUserInteractionEnabled = true
                }
            }
        

    }
    
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        if imageArray.count >= 1 {
            performSegue(withIdentifier: "showImage", sender: self)
        }
        
        imageChoose = sender.tag
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage"{
            let destinationVC = segue.destination as! ImagePreviewController
                destinationVC.image = imageArray[imageChoose]
        }else if segue.identifier == "playVideo"{
            let destinationVC = segue.destination as! VideoViewController
            destinationVC.videosource = imageArray
        }
    }
    
    
    
    
    
    
    @IBAction func videoGenerated(_ sender: UIButton) {
        loadFile()
        performSegue(withIdentifier: "playVideo", sender: self)
    }
    private func loadFile(){
        let manager = FileManager()
        let docUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = docUrl?.appendingPathComponent("photoArray.txt")
        if let array = NSArray(contentsOf: url!){
            photoArray = array as! [String]
            trimVideo()
        }
    }
    private func trimVideo(){
        let manager = FileManager()
        let docUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        for n in 0...(photoArray.count-1) {
            if let url = docUrl?.appendingPathComponent(photoArray[n]){
                if let image = UIImage(contentsOfFile: url.path){
                    imageArray.append(image)
                }
            }
        }
    }
}
