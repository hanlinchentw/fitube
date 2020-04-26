//
//  ProgramViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/14.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import CoreData

protocol sentBackData {
    func dismissBack(sendData:String)
}
protocol lastExercise {
    func trainingStaus(status :Float)
}
@available(iOS 13.0, *)
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
    
    @IBOutlet weak var warmButton: UIButton!
    @IBOutlet weak var photoLabel: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var completedButton: UIButton!
    
    var trainProgressBar = UIProgressView(progressViewStyle: .bar)
    var progressLabel = UILabel()
    @IBOutlet weak var warmupBlur: UIView!
    @IBOutlet weak var trainingBlur: UIView!
    @IBOutlet weak var selfieBlur: UIView!
    
    
    @IBOutlet var imageArray: [UIImageView]!
    //MARK: - Data container
    var photoArray :[String] = []
    
    let defaults = UserDefaults.standard
    var userData = [Usersinfo]()
    private var userlevel = [UsersLevel]()
    
    let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//MARK: - view delegate method
    var imagePreview = ImagePreviewController()
    var timeRemaining = "10 mins cardio"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let infoRequest :NSFetchRequest<Usersinfo> = Usersinfo.fetchRequest()
        let levelRequset :NSFetchRequest<UsersLevel> = UsersLevel.fetchRequest()
        userData =  loadUserInfo(request: infoRequest as! NSFetchRequest<NSFetchRequestResult>) as! [Usersinfo]
        userlevel =  loadUserInfo(request: levelRequset as! NSFetchRequest<NSFetchRequestResult>) as! [UsersLevel]
                
                
        nameLabel.text =  userData[0].name
        dateLabel.text = dateFetch()
        levelLabel.text = "  Current level : \(userlevel[0].levelDescription!)"
        dayPassed = 0 // test
        //        dayPassed = defaults.integer(forKey: "passedDay")
        part = leveldetermine(day: dayPassed)
        imagePreview.delegate = self
                    
        trainButton.setTitle(part[0], for: .normal)
        userDoneTheChanllenge = false // test
        
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
        warmupBlur.translatesAutoresizingMaskIntoConstraints = false
        trainingBlur.translatesAutoresizingMaskIntoConstraints = false
        selfieBlur.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: nameLabel!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: (view.frame.height)/50).isActive = true
        NSLayoutConstraint(item: nameLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
        dividerImage.contentMode = .scaleAspectFill
        NSLayoutConstraint(item: dividerImage!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: -view.frame.height/20).isActive = true
        NSLayoutConstraint(item: dividerImage!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant:0).isActive = true

        NSLayoutConstraint(item: dateLabel!, attribute: .top, relatedBy: .equal, toItem: dividerImage, attribute: .bottom, multiplier: 1, constant: -15).isActive = true
        NSLayoutConstraint(item: dateLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/20).isActive = true
        
        NSLayoutConstraint(item: levelLabel!, attribute: .top, relatedBy: .equal, toItem: dividerImage, attribute: .bottom, multiplier: 1, constant:-15).isActive = true
        NSLayoutConstraint(item: levelLabel!, attribute: .leading, relatedBy: .equal, toItem: dateLabel, attribute: .trailing, multiplier: 1, constant: view.frame.width/5).isActive = true
        
        NSLayoutConstraint(item: dummyLabel!, attribute: .top, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: (view.frame.height)/99).isActive = true
        NSLayoutConstraint(item: dummyLabel!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/20).isActive = true
        
        workView.layer.cornerRadius = 10
        workView.layer.borderWidth = 5
        workView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        workView.backgroundColor = #colorLiteral(red: 0.2851659656, green: 0.4760053754, blue: 0.7123829722, alpha: 1)
        NSLayoutConstraint(item: workView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: workView!, attribute: .top, relatedBy: .equal, toItem: dummyLabel, attribute: .bottom, multiplier: 1, constant: (view.frame.height)/50).isActive = true
        NSLayoutConstraint(item: workView!, attribute: .bottom, relatedBy: .equal, toItem: imageArray[2], attribute: .bottom, multiplier: 1, constant: view.frame.height/50).isActive = true
        NSLayoutConstraint(item: workView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/30).isActive = true
        NSLayoutConstraint(item: workView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -view.frame.width/30).isActive = true
        
        NSLayoutConstraint(item: imageArray[0], attribute: .top, relatedBy: .equal, toItem: workView, attribute: .top, multiplier: 1, constant: view.frame.height/50).isActive = true
        
        for n in 0...2{
            imageArray[n].translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: imageArray[n], attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.2, constant: 0).isActive = true
            NSLayoutConstraint(item: imageArray[n], attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.8, constant: 0).isActive = true
            NSLayoutConstraint(item: imageArray[n], attribute: .centerX, relatedBy: .equal, toItem: workView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
            if n >= 1 {
                NSLayoutConstraint(item: imageArray[n], attribute: .top, relatedBy: .equal, toItem: imageArray[n-1], attribute: .bottom, multiplier: 1, constant: view.frame.height/60).isActive = true
            }

        }
        view.addSubview(trainProgressBar)
        trainProgressBar.translatesAutoresizingMaskIntoConstraints = false
        trainProgressBar.progress = 0
        trainProgressBar.progressTintColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
        trainProgressBar.trackTintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        NSLayoutConstraint(item: trainProgressBar, attribute: .bottom, relatedBy: .equal, toItem: trainButton, attribute: .bottom, multiplier: 1, constant: -trainButton.frame.height).isActive = true
        NSLayoutConstraint(item: trainProgressBar, attribute: .leading, relatedBy: .equal, toItem: trainButton, attribute: .leading, multiplier: 1, constant: trainButton.frame.width/5).isActive = true
        NSLayoutConstraint(item: trainProgressBar, attribute: .trailing, relatedBy: .equal, toItem: trainButton, attribute: .trailing, multiplier: 1, constant: -trainButton.frame.width/5).isActive = true
        NSLayoutConstraint(item: trainProgressBar, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        view.addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.text = String(format: "%0m", trainProgressBar.progress*100) + " %"
        progressLabel.textColor = .white
        NSLayoutConstraint(item: progressLabel, attribute: .trailing, relatedBy: .equal, toItem: trainProgressBar, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: progressLabel, attribute: .bottom, relatedBy: .equal, toItem: trainProgressBar, attribute: .top, multiplier: 1, constant: 0).isActive = true

        fit(addView: warmButton, underView: imageArray[0])
        fit(addView: trainButton, underView: imageArray[1])
        fit(addView: photoLabel, underView: imageArray[2])
        fit(addView: warmupBlur, underView: imageArray[0])
        fit(addView: trainingBlur, underView: imageArray[1])
        fit(addView: selfieBlur, underView: imageArray[2])
        let transitionSize = 25*view.frame.height/725
        warmButton.titleLabel?.font.withSize(transitionSize)
        trainButton.titleLabel?.font.withSize(transitionSize)
        photoLabel.titleLabel?.font.withSize(transitionSize)
        nameLabel.font.withSize(transitionSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        
    }
        
    
    //MARK: - Make blue fit
    func fit(addView : UIView,underView:UIView){
        
        NSLayoutConstraint(item: addView, attribute: .centerX, relatedBy: .equal, toItem: underView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addView, attribute: .centerY, relatedBy: .equal, toItem: underView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addView, attribute: .height, relatedBy: .equal, toItem: underView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: addView, attribute: .width, relatedBy: .equal, toItem: underView, attribute: .width, multiplier: 1, constant: 0).isActive = true
    }
    
    //MARK: - Buttons
    
    @IBAction func warmUpButtonPressed(_ sender: UIButton) {
        userDoneTheChanllenge = false
    }
    
    
    var part :[String] = []
    @IBAction func trainingSection(_ sender: UIButton) {
        
        performSegue(withIdentifier: "startTraining", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "startTraining"{
            let destinationVC = segue.destination as! PopUpViewController
            destinationVC.trainingNote = part
            destinationVC.delegate = self
        } else if segue.identifier == "warmup"{
            let destinationVC = segue.destination as! WarmupViewController
            destinationVC.delegate = self
        }
    }
    
    @IBAction func takePhoto(_ sender: UIButton) {
        
        let imagepicker = UIImagePickerController()
        imagepicker.sourceType = .camera
        imagepicker.delegate = self
        present(imagepicker, animated: true, completion: nil)
        
    }
    
    @IBAction func completedButtonPressed(_ sender: UIButton) {
        sender.tintColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
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
        let selectTime = "2020/4/25 03:00"
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
            defaults.set(newValue, forKey: "doneToday")
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
        showAlbum()
    }
    func showAlbum(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}
@available(iOS 13.0, *)
extension ProgramViewController : sentBackData{
    func dismissBack(sendData: String) {
        warmButton.titleLabel?.numberOfLines = 0

        warmButton.setTitle(sendData, for: .normal)
        if warmButton.currentTitle! == "   Finished!"{
            warmButton.isUserInteractionEnabled = false
            warmButton.tintColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
        }else{
            warmButton.isUserInteractionEnabled = true
            
        }
    }
    
}
@available(iOS 13.0, *)
extension ProgramViewController : lastExercise{
    func trainingStaus(status: Float) {
        trainProgressBar.progress = status
        progressLabel.text = String(Int(status*100)) + " %"
        if status == 1 {
            trainButton.setTitle("   Finished!", for: .normal)
            trainButton.isUserInteractionEnabled = false
            trainButton.tintColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
        }else if status == 0 {
            trainButton.setTitle(part[0], for: .normal)
            trainButton.isUserInteractionEnabled = true
        }else{
            trainButton.setTitle("Click to continue", for: .normal)
            trainButton.isUserInteractionEnabled = true
        }
    }
}
