//
//  VideoViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/25.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import AVFoundation
class VideoViewController: UITabBarController {
    
  
    private var videoView = UIView()
    private var downloadButton = UIButton()
    var videosource  : [UIImage]?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        navigationController?.navigationBar.tintColor = .black
        view.addSubview(videoView)
        self.videoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.videoView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.videoView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.videoView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.7, constant: 0).isActive = true
        NSLayoutConstraint(item: self.videoView, attribute: .width, relatedBy: .equal, toItem: self.videoView, attribute: .height, multiplier: 16/9, constant: 0).isActive = true
        self.videoView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
        
        view.addSubview(downloadButton)
        self.downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.setTitle("Download", for: .normal)
        NSLayoutConstraint(item: self.downloadButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.downloadButton, attribute: .top, relatedBy: .equal, toItem: self.videoView, attribute: .bottom, multiplier: 1, constant: view.frame.height*0.3).isActive = true
       
        downloadButton.addTarget(self, action: #selector(downloadButtonPressed(sender:)) , for: .touchUpInside)
        
        createVideo()
        
    }
    @objc func downloadButtonPressed(sender:UIButton){
        DispatchQueue.main.async {
            UISaveVideoAtPathToSavedPhotosAlbum(self.url!.path, nil, nil, nil)
        }
    }
    var url : URL?
    private func createVideo() {
        guard let source = videosource else {
            fatalError("Wrong sorce, check if it's nil.")
        }
        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecType.h264.rawValue, width: (source[0].cgImage?.width)!, height: (source[0].cgImage?.height)!)
        let movieMaker = CXEImagesToVideo(videoSettings: settings)
        movieMaker.createMovieFrom(images: source){ (fileURL:URL) in
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(fileURL.path){
                let video = AVAsset(url: fileURL)
                let playerItem = AVPlayerItem(asset: video)
                let avPlayer = AVPlayer(playerItem: playerItem)
                let playerLayer = AVPlayerLayer(player: avPlayer)
                playerLayer.needsDisplayOnBoundsChange = true
                self.videoView.layer.addSublayer(playerLayer)
                playerLayer.videoGravity = .resizeAspect
                playerLayer.frame = self.videoView.bounds
                avPlayer.play()
                self.url = fileURL
//                DispatchQueue.main.async {
//                    UISaveVideoAtPathToSavedPhotosAlbum(fileURL.path, nil, nil, nil)
//                }
            }
        }
    }
        
        
        
}
