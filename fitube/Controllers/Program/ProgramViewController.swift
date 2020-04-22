//
//  ProgramViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/14.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import CoreData

class ProgramViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, whatUserTrain{
    func fetchTrainingProgram() ->[String] {
        return part
    }
    
//MARK: - IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var dividerImage: UIImageView!
    @IBOutlet weak var dummyLabel: UILabel!
    
    
    @IBOutlet weak var workView: UIView!
    @IBOutlet weak var buttonStack: UIStackView!
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
    var imagePreview = ImagePreviewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurIfDone(if: userDoneTheChanllenge)
       //MARK: - Auto layout manager
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dividerImage.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        dummyLabel.translatesAutoresizingMaskIntoConstraints = false
        workView.translatesAutoresizingMaskIntoConstraints = false
        warmButton.translatesAutoresizingMaskIntoConstraints = false
        trainButton.translatesAutoresizingMaskIntoConstraints = false
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: nameLabel!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: (view.frame.height)/40).isActive = true
        NSLayoutConstraint(item: nameLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        dividerImage.contentMode = .scaleAspectFill
        NSLayoutConstraint(item: dividerImage!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: -view.frame.height/40).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant:0).isActive = true

        NSLayoutConstraint(item: dateLabel!, attribute: .top, relatedBy: .equal, toItem: dividerImage, attribute: .bottom, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: dateLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/20).isActive = true
        
        NSLayoutConstraint(item: levelLabel!, attribute: .top, relatedBy: .equal, toItem: dividerImage, attribute: .bottom, multiplier: 1, constant:-15).isActive = true
        NSLayoutConstraint(item: levelLabel!, attribute: .leading, relatedBy: .equal, toItem: dateLabel, attribute: .trailing, multiplier: 1, constant: view.frame.width/5).isActive = true
        
        NSLayoutConstraint(item: dummyLabel!, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: (view.frame.height)/99).isActive = true
        NSLayoutConstraint(item: dummyLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/20).isActive = true
        
        workView.layer.cornerRadius = 20
        workView.backgroundColor = #colorLiteral(red: 0.2303010523, green: 0.4739870429, blue: 0.7338336706, alpha: 1)
        NSLayoutConstraint(item: workView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: workView!, attribute: .top, relatedBy: .equal, toItem: dummyLabel, attribute: .bottom, multiplier: 1, constant: (view.frame.height)/100).isActive = true

        NSLayoutConstraint(item: workView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/20).isActive = true
        NSLayoutConstraint(item: workView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -view.frame.width/20).isActive = true
        
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = view.frame.height/35
        NSLayoutConstraint(item: buttonStack!, attribute: .centerX, relatedBy: .equal, toItem: workView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: buttonStack!, attribute: .trailing, relatedBy: .equal, toItem: workView, attribute: .trailing, multiplier: 1, constant: -view.frame.width/20).isActive = true
        NSLayoutConstraint(item: buttonStack!, attribute: .top, relatedBy: .equal, toItem: workView, attribute: .top, multiplier: 1, constant: (view.frame.height)/50).isActive = true
        NSLayoutConstraint(item: buttonStack!, attribute: .leading, relatedBy: .equal, toItem: workView, attribute: .leading, multiplier: 1, constant: view.frame.width/20).isActive = true
        NSLayoutConstraint(item: buttonStack!, attribute: .bottom, relatedBy: .equal, toItem: workView, attribute: .bottom, multiplier: 1, constant: -(view.frame.height)/50).isActive = true
        NSLayoutConstraint(item: warmButton!, attribute: .height, relatedBy: .equal,
                           toItem: view, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: warmButton!, attribute: .width, relatedBy: .equal,
                           toItem: view, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: trainButton! , attribute: .height, relatedBy: .equal,
                           toItem: view, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: trainButton!, attribute: .width, relatedBy: .equal,
                           toItem: view, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: photoLabel! , attribute: .height, relatedBy: .equal,
                           toItem: view, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
        NSLayoutConstraint(item: photoLabel!, attribute: .width, relatedBy: .equal,
                           toItem: view, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
        
        
        completedButton.layer.cornerRadius = 5
        
        let infoRequest :NSFetchRequest<Usersinfo> = Usersinfo.fetchRequest()
        let levelRequset :NSFetchRequest<UsersLevel> = UsersLevel.fetchRequest()
        userData =  loadUserInfo(request: infoRequest as! NSFetchRequest<NSFetchRequestResult>) as! [Usersinfo]
        userlevel =  loadUserInfo(request: levelRequset as! NSFetchRequest<NSFetchRequestResult>) as! [UsersLevel]
        
        
        nameLabel.text =  userData[0].name
        dateLabel.text = "Date: "+dateFetch()
        levelLabel.text = "level : \(userlevel[0].levelDescription!)"
        dayPassed = 1 // test

//        dayPassed = defaults.integer(forKey: "passedDay")
        part = leveldetermine(day: dayPassed)
        imagePreview.delegate = self

        userDoneTheChanllenge = false //test

        
        let warmupBlur = UIView()
        let warmButtonLabel = UILabel()
        blurConstraints(addView: warmupBlur, label: warmButtonLabel,button: warmButton)
        warmButtonLabel.text = "Ten minutes Cardio"
    
        let trainingBlur = UIView()
        let trainingLabel = UILabel()
        blurConstraints(addView: trainingBlur, label: trainingLabel, button: trainButton)
        trainingLabel.text = part[0]
        
        let selfieBlur = UIView()
        let selfieButtonLabel = UILabel()
        blurConstraints(addView: selfieBlur, label: selfieButtonLabel, button: photoLabel)
        selfieButtonLabel.text = "Take a sefie"
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        
    }
    //MARK: - Constraints
    func blurConstraints(addView : UIView, label:UILabel,button:UIButton){
        view.addSubview(addView)
        view.addSubview(label)
        
        addView.backgroundColor = .black
        addView.alpha = 0.6
        addView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: addView, attribute: .centerX, relatedBy: .equal, toItem: button, attribute: .centerX, multiplier: 1, constant: 0).isActive  = true
        NSLayoutConstraint(item: addView, attribute: .top, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addView, attribute: .bottom, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addView, attribute: .leading, relatedBy: .equal, toItem: button, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addView, attribute: .trailing, relatedBy: .equal, toItem: button, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    
        label.textColor = .white
        label.font.withSize(17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: button, attribute: .centerX, multiplier: 1, constant: 0).isActive  = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    
    
    //MARK: - Buttons
    
    @IBAction func warmUpButtonPressed(_ sender: UIButton) {
        userDoneTheChanllenge = false
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
        
        if segue.identifier == "startTraining"{
            let destinationVC = segue.destination as! TrainViewController
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
        
        sender.isUserInteractionEnabled = false
        dayPassed += 1
        userDoneTheChanllenge = true
        resetChallenge()
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
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"zh_TW")
        dateFormatter.dateFormat = "MM / dd"
        let stringDate = dateFormatter.string(from: currentDate)
        return stringDate
    }
    
    
    func resetChallenge(){
  
        let formatters = DateFormatter()
        formatters.dateFormat = "yyyy/MM/dd hh:mm"
        let selectTime = "2020/4/21 03:00"
        let nextTime = formatters.date(from: selectTime)
        if let interval = nextTime?.timeIntervalSince(Date()){
            let t = RepeatingTimer(timeInterval: interval)
            t.eventHandler = {
                self.userDoneTheChanllenge = false
            }
            t.resume()
        }
        
        
    }
    
    
    //MARK: - defaults method

    var dayPassed :Int{
        get{
            defaults.integer(forKey: "passedDay")
        }
        set{
            defaults.set(newValue, forKey: "passedDay")
        }
    }
    var userDoneTheChanllenge :Bool{
        get{
            defaults.bool(forKey: "doneToday")
        }
        set{
            blurIfDone(if: newValue)
            defaults.set(newValue, forKey: "doneToday")
        }
    }
    //MARK: - blur user view method
    func blurIfDone(if done : Bool){
        let blurView = UIView()
        let doneLabel = UILabel()
        blurView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        blurView.backgroundColor = #colorLiteral(red: 0.004888398107, green: 0, blue: 0.1756066084, alpha: 1)
        doneLabel.text = "You have already finished the Chanllenge today."
        doneLabel.textColor = .white
        blurView.addSubview(doneLabel)
        if done == true{
            view.addSubview(blurView)
        }else{
            blurView.isHidden = true
        }
    }

    //MARK: - level determine
    func leveldetermine(day: Int) -> [String]{
        switch userlevel[0].levelDescription {
        case "Beginner":
            return Beginner(day: day).trainingPart()
        case "Intermediate":
            return Intermediate(day:day).trainingPart()
        case "Advanced":
            return Advanced(day: day).trainingPart()
        case "Beast":
            return Beast(day: day).trainingPart()
        default:
            fatalError("Can't give you a suitable program. You are beyond human.")
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
