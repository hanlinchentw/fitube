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

    private var photoArray :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func videoGenerated(_ sender: UIButton) {
            loadFile()
            trimVideo()
            playVideo()
    }
    
    private func loadFile(){
        let manager = FileManager()
        let docUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = docUrl?.appendingPathComponent("photoArray.txt")
        if let array = NSArray(contentsOf: url!){
           photoArray = array as! [String]
        }
    }
    private func trimVideo(){
        let size = CGSize(width: 1920, height: 1280)
        let manager = FileManager()
        let docUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        var imageArray : [UIImage] = []
        for n in 0...photoArray.count{
            if let url = docUrl?.appendingPathComponent(photoArray[n]){
                if let image = UIImage(contentsOfFile: url.path){
                    imageArray.append(image)
                }
            }
        }
        writeImagesAsMovie(allImages: imageArray, videoPath: docUrl!.absoluteString+"/FitubeResult.mp4", videoSize: size, videoFPS: 30)
        
    }
     private func playVideo() {
           guard let path = Bundle.main.path(forResource: "FitubeResult", ofType:"mp4") else {
               debugPrint("video.m4v not found")
               return
           }
           let player = AVPlayer(url: URL(fileURLWithPath: path))
           let playerController = AVPlayerViewController()
           playerController.player = player
           present(playerController, animated: true) {
               player.play()
           }
       }
    
  //MARK: - Clip Video Method
    func writeImagesAsMovie(allImages: [UIImage], videoPath: String, videoSize: CGSize, videoFPS: Int32) {
        // Create AVAssetWriter to write video
        guard let assetWriter = createAssetWriter(path: videoPath, size: videoSize) else {
            print("Error converting images to video: AVAssetWriter not created")
            return
        }

        // If here, AVAssetWriter exists so create AVAssetWriterInputPixelBufferAdaptor
        let writerInput = assetWriter.inputs.filter{ $0.mediaType == AVMediaType.video }.first!
        let sourceBufferAttributes : [String : Any] = [
            kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32ARGB),
            kCVPixelBufferWidthKey as String : videoSize.width,
            kCVPixelBufferHeightKey as String : videoSize.height
            ]
        let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput, sourcePixelBufferAttributes: sourceBufferAttributes)

        // Start writing session
        assetWriter.startWriting()
        assetWriter.startSession(atSourceTime: CMTime.zero)
        if (pixelBufferAdaptor.pixelBufferPool == nil) {
            print("Error converting images to video: pixelBufferPool nil after starting session")
            return
        }

        // -- Create queue for <requestMediaDataWhenReadyOnQueue>
        let mediaQueue = DispatchQueue(__label: "mediaInputQueue", attr: nil)

        // -- Set video parameters
        let frameDuration = CMTimeMake(value: 1, timescale: videoFPS)
        var frameCount = 0

        // -- Add images to video
        let numImages = allImages.count
        writerInput.requestMediaDataWhenReady(on: mediaQueue, using: { () -> Void in
            // Append unadded images to video but only while input ready
            while (writerInput.isReadyForMoreMediaData && frameCount < numImages) {
                let lastFrameTime = CMTimeMake(value: Int64(frameCount), timescale: videoFPS)
                let presentationTime = frameCount == 0 ? lastFrameTime : CMTimeAdd(lastFrameTime, frameDuration)

                if !self.appendPixelBufferForImageAtURL(image: allImages[frameCount], pixelBufferAdaptor: pixelBufferAdaptor, presentationTime: presentationTime) {
                    print("Error converting images to video: AVAssetWriterInputPixelBufferAdapter failed to append pixel buffer")
                    return
                }

                frameCount += 1
            }

            // No more images to add? End video.
            if (frameCount >= numImages) {
                writerInput.markAsFinished()
                assetWriter.finishWriting {
                    if (assetWriter.error != nil) {
                        print("Error converting images to video: \(assetWriter.error!)")
                    } else {
                        self.saveVideoToLibrary(videoURL: NSURL(fileURLWithPath: videoPath))
                        print("Converted images to movie @ \(videoPath)")
                    }
                }
            }
        })
    }


    func createAssetWriter(path: String, size: CGSize) -> AVAssetWriter? {
        // Convert <path> to NSURL object
        let pathURL = NSURL(fileURLWithPath: path)

        // Return new asset writer or nil
        do {
            // Create asset writer
            let newWriter = try AVAssetWriter(outputURL: pathURL as URL, fileType: AVFileType.mp4)

            // Define settings for video input
            let videoSettings: [String : Any] = [
                AVVideoCodecKey  : AVVideoCodecType.h264,
                AVVideoWidthKey  : size.width,
                AVVideoHeightKey : size.height,
                ]

            // Add video input to writer
            let assetWriterVideoInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoSettings)
            newWriter.add(assetWriterVideoInput)

            // Return writer
            print("Created asset writer for \(size.width)x\(size.height) video")
            return newWriter
        } catch {
            print("Error creating asset writer: \(error)")
            return nil
        }
    }


    func appendPixelBufferForImageAtURL(image: UIImage, pixelBufferAdaptor: AVAssetWriterInputPixelBufferAdaptor, presentationTime: CMTime) -> Bool {
        var appendSucceeded = false

        autoreleasepool {
            if  let pixelBufferPool = pixelBufferAdaptor.pixelBufferPool {
                let pixelBufferPointer = UnsafeMutablePointer<CVPixelBuffer?>.allocate(capacity: 1)
                let status: CVReturn = CVPixelBufferPoolCreatePixelBuffer(
                    kCFAllocatorDefault,
                    pixelBufferPool,
                    pixelBufferPointer
                )

                if let pixelBuffer = pixelBufferPointer.pointee, status == 0 {
                    fillPixelBufferFromImage(image: image, pixelBuffer: pixelBuffer)
                    appendSucceeded = pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: presentationTime)
                    pixelBufferPointer.deinitialize(count: 1)
                } else {
                    NSLog("Error: Failed to allocate pixel buffer from pool")
                }

                pixelBufferPointer.deallocate()
            }
        }

        return appendSucceeded
    }


    func fillPixelBufferFromImage(image: UIImage, pixelBuffer: CVPixelBuffer) {
        CVPixelBufferLockBaseAddress(pixelBuffer, [])

        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()

        // Create CGBitmapContext
        let context = CGContext(
            data: pixelData,
            width: Int(image.size.width),
            height: Int(image.size.height),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
            space: rgbColorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
        )

        // Draw image into context
        if let safeimage = image.cgImage, let safecontext = context{
            safecontext.draw(safeimage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }
        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
    }


    func saveVideoToLibrary(videoURL: NSURL) {
        PHPhotoLibrary.requestAuthorization { status in
            // Return if unauthorized
            guard status == .authorized else {
                print("Error saving video: unauthorized access")
                return
            }

            // If here, save video to library
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL as URL)
            }) { success, error in
                if let e = error {
                    print("Error saving video: \(e)")
                }
            }
        }
    }
}
