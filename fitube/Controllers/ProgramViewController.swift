//
//  ProgramViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/14.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import CoreData

class ProgramViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var levelLabel: UIImageView!
    @IBOutlet weak var warmButton: UIButton!
    @IBOutlet weak var photoLabel: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    var photoArray :[String] = []
    var userData = [Users]()
    let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLayoutConstraint(item: photoLabel , attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.13, constant: 0).isActive = true
        NSLayoutConstraint(item: photoLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
//        photoLabel.titleLabel?.font = UIFont(name: "", size: photoLabel.frame.height/3)
//        trainButton.titleLabel?.font = UIFont(name: "", size: photoLabel.frame.height/3)
//        warmButton.titleLabel?.font = UIFont(name: "", size: photoLabel.frame.height/3)
//        completedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        NSLayoutConstraint(item: completedButton!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier:1, constant: (view.frame.height)/20).isActive = true
        
        photoLabel.layer.cornerRadius = 10
        trainButton.layer.cornerRadius = 10
        warmButton.layer.cornerRadius = 10
        completedButton.layer.cornerRadius = 5
        
        let request :NSFetchRequest<Users> = Users.fetchRequest()
        do {
           userData =  try contexts.fetch(request)
        }catch{
            fatalError("fetch user data error:\(error)")
        }
        
        
        
        
        
        
    }
    @IBAction func warmUpButtonPressed(_ sender: UIButton) {
    }
    @IBAction func trainingSection(_ sender: UIButton) {
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .camera
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let newImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil)
            let fileManager = FileManager.default
            let imageUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let interval = Date.timeIntervalSinceReferenceDate
            let name = "\(interval).jpg"
            let url = imageUrls?.appendingPathComponent(name)
            
            let data = newImage.jpegData(compressionQuality: 0.9)
            if let safeurl = url{
               try! data?.write(to: safeurl)
            }
            photoArray.append(name)
            saveImage()
        }
        dismiss(animated: true, completion: nil)
    }
    func saveImage() {
        let fileManager = FileManager.default
        let imageUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = imageUrls?.appendingPathComponent("photoArray.txt")
        let array = photoArray
        (array as NSArray).write(to: url!, atomically: true)
    }
    func showAlbum(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func completedButtonPressed(_ sender: UIButton) {
    }

}
