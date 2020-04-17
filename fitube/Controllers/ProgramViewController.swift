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
//MARK: - IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var passedDayLabel: UILabel!
    
    
    @IBOutlet weak var warmButton: UIButton!
    @IBOutlet weak var photoLabel: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
//MARK: - Data container
    var photoArray :[String] = []
    
    let defaults = UserDefaults.standard
    var userData = [Usersinfo]()
    private var userlevel = [UsersLevel]()
    
    let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//MARK: - view delegate method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLayoutConstraint(item: photoLabel! , attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.13, constant: 0).isActive = true
        NSLayoutConstraint(item: photoLabel!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
        
        photoLabel.layer.cornerRadius = 10
        trainButton.layer.cornerRadius = 10
        warmButton.layer.cornerRadius = 10
        completedButton.layer.cornerRadius = 5
        
        let infoRequest :NSFetchRequest<Usersinfo> = Usersinfo.fetchRequest()
        let levelRequset :NSFetchRequest<UsersLevel> = UsersLevel.fetchRequest()
        userData =  loadUserInfo(request: infoRequest as! NSFetchRequest<NSFetchRequestResult>) as! [Usersinfo]
        userlevel =  loadUserInfo(request: levelRequset as! NSFetchRequest<NSFetchRequestResult>) as! [UsersLevel]
        
        
        nameLabel.text =  userData[0].name
        dateLabel.text = dateFetch()
        levelLabel.text = "\(userlevel[0].levelDescription!)"
        
        dayPassed = defaults.integer(forKey: "passedDay")
        var trainingPart = RookieProgram(day: dayPassed).trainingPart()
        part = trainingPart
        trainButton.setTitle(trainingPart[0], for: .normal)
        
    }
    

    //MARK: - Buttons
    
    @IBAction func warmUpButtonPressed(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        trainButton.backgroundColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
        sender.isUserInteractionEnabled = false
        trainButton.isUserInteractionEnabled  = true
    }
    
    
    var part :[String] = []
    @IBAction func trainingSection(_ sender: UIButton) {
        sender.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        photoLabel.backgroundColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
        
        sender.isUserInteractionEnabled = false
        photoLabel.isUserInteractionEnabled = true
        
        performSegue(withIdentifier: "startTraining", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TrainViewController
        if segue.identifier == "startTraining"{
            destinationVC.trainingSection = part
        } 
    }
    
    
    
    
    @IBAction func takePhoto(_ sender: UIButton) {
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .camera
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
        
    }
    
    @IBAction func completedButtonPressed(_ sender: UIButton) {
        dayPassed += 1
    }
    
    //MARK: - load up user information
    func loadUserInfo( request : NSFetchRequest<NSFetchRequestResult>) ->[NSManagedObject] {
        
               do {
                return try contexts.fetch(request) as! [NSManagedObject]
               }catch{
                    fatalError("fetch user data error:\(error)")
               }
    }
    
    
    //MARK: -  Fetch date method
    func dateFetch()->String{
        let currentData = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"zh_TW")
        dateFormatter.dateFormat = "MM/dd"
        let stringDate = dateFormatter.string(from: currentData)
        return stringDate
    }
    //MARK: - training day counting

        
        var dayPassed :Int{
            get{
                defaults.integer(forKey: "passedDay")
            }
            set{
                
                passedDayLabel.text = "Passed day: \(newValue)"
                defaults.set(newValue, forKey: "passedDay")
            }
        }
    
    
        
    
    
    
    
    
    
    
    //MARK: - Photo method
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
}
