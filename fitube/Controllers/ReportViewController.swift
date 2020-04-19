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



class ReportViewController: UIViewController, UINavigationControllerDelegate{

    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var borderView: UIView!
    
    private var photoArray :[String] = []
    var imageArray : [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        generateButton.layer.cornerRadius = 10
        borderView.layer.cornerRadius = 20
        borderView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        borderView.layer.borderWidth = 2
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
            playerLayer.frame = self.videoContainer.bounds
            playerLayer.videoGravity = .resizeAspectFill
            self.videoContainer.layer.addSublayer(playerLayer)
            
            UISaveVideoAtPathToSavedPhotosAlbum(fileURL.absoluteString, nil, nil, nil)
            avPlayer.play()
        }
    }
}
