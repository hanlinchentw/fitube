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
import SwiftVideoCreator
import Photos



@available(iOS 13.0, *)
class ReportViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var generateButton: UIButton!
 
    @IBOutlet weak var finishedDay: UILabel!
    @IBOutlet var dayButtonCollection: [UIButton]!
    @IBOutlet weak var borderView: UIView!
    
    let defaults = UserDefaults.standard
    
    private var photoArray :[String] = []
    var imageArray : [UIImage] = []
    
    var imageChoose = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for n in 1...30{
            dayButtonCollection[n-1].setBackgroundImage(UIImage(systemName:"\(n).square"), for: .normal)
        }
        
        finishedDay.text = String(defaults.integer(forKey: "passedDay"))
        
        NSLayoutConstraint(item: dayButtonCollection[0], attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1/8, constant: 0).isActive = true
        
        generateButton.layer.cornerRadius = 10
        borderView.layer.cornerRadius = 20
        borderView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        borderView.layer.borderWidth = 2
        if let day = Int(finishedDay.text!){
            if day == 0{
                
            }else{
                for n in 0...day-1{
                    dayButtonCollection[n].setBackgroundImage(UIImage(systemName: "checkmark.shield.fill"), for: .normal)
                    dayButtonCollection[n].tintColor = #colorLiteral(red: 0, green: 0.5704279542, blue: 0.3237726688, alpha: 1)
                    dayButtonCollection[n].tag = n
                    dayButtonCollection[n].isUserInteractionEnabled = true
                }
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
        }
    }
    @IBAction func videoGenerated(_ sender: UIButton) {
        loadFile()
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
        playVideo()
    }

    
    private func playVideo() {
        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecType.h264.rawValue, width: (imageArray[0].cgImage?.width)!, height: (imageArray[0].cgImage?.height)!)
        let movieMaker = CXEImagesToVideo(videoSettings: settings)
        movieMaker.createMovieFrom(images: imageArray){ (fileURL:URL) in
            let video = AVAsset(url: fileURL)
            
            let playerItem = AVPlayerItem(asset: video)
            let avPlayer = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: avPlayer)
//            playerLayer.frame = self.videoContainer.bounds
//            playerLayer.videoGravity = .resizeAspectFill
//            self.videoContainer.layer.addSublayer(playerLayer)
            
            UISaveVideoAtPathToSavedPhotosAlbum(fileURL.absoluteString, nil, nil, nil)
            avPlayer.play()
        }
    }
}
