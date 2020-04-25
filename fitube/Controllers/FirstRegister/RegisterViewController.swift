//
//  UserDataController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/12.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var trainFrequency: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var titleStack: UIStackView!
    @IBOutlet weak var textFieldStack: UIStackView!
    
    
    
    
    let frequencyArray = ["0 /week","1~3 /week","3~5 /week","5~7 /week"]
    var picker = UIPickerView()
    
    let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let user = [Usersinfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        print (filePath)
        picker.dataSource = self
        picker.delegate = self
        trainFrequency.inputView = picker
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
        
        NSLayoutConstraint(item: titleStack!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleStack!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: titleStack!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: view.frame.width/20).isActive = true
        NSLayoutConstraint(item: titleStack!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -view.frame.width/20).isActive = true
        
        textFieldStack.spacing = view.frame.height/20
        NSLayoutConstraint(item: textFieldStack!, attribute: .top, relatedBy: .equal, toItem: titleStack, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: textFieldStack!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: textFieldStack!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.layer.cornerRadius = 20
        NSLayoutConstraint(item: doneButton!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.07, constant: 0).isActive = true
        NSLayoutConstraint(item: doneButton!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        NSLayoutConstraint(item: doneButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: doneButton!, attribute: .top, relatedBy: .equal, toItem: trainFrequency, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
    }
    
    @objc func closeKeyboard(){
    self.view.endEditing(true)
    }
    
    @IBAction func DoneButtonPressed(_ sender: UIButton) {
        let newUser = Usersinfo(context: contexts)
        if let namee = nameTextField.text, let age = Int32(ageTextField.text!),
            let height = Double(heightTextField.text!), let weight = Double(weightTextField.text!),
            let trFrequency = trainFrequency.text{
                newUser.name = namee
                newUser.age = age
                newUser.height = height
                newUser.weight = weight
                newUser.frequency = trFrequency
                
                performSegue(withIdentifier: "doneRegister", sender: self)
            
                save()
        }else{
            let alert = UIAlertController(title: "Info. incomplete", message: "Your information is incomplete.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Check again",style : .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            print("nil")
        }
//        UserDefaults.standard.set(true, forKey: "ALLREADY_REGISTER")
    }
    
    
    //MARK: - Data manipulation Method
    func save(){
        do{
            deleteAllData(entity:"Usersinfo")
            try contexts.save()
            print ("info save.")
        }catch{
            print("Save error:\(error)")
        }
    }
    func deleteAllData(entity: String){
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity )
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do {
            try contexts.execute(DelAllReqVar)
            
        }catch { print(error) }
        
    }
}
    

extension RegisterViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frequencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frequencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        trainFrequency.text = frequencyArray[row]
    }
}
