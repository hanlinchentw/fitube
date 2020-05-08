//
//  UserDataController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/12.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import CoreData
import SnapKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var trainFrequency: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleStack: UIStackView!
    @IBOutlet weak var textFieldStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        trainFrequency.inputView = picker
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
        setupView()
        print (filePath)
        
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
                
                
            let alert = UIAlertController(title: "Save", message: "Please check your Info again, make sure you type the right one.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .default) { (action) in
                self.performSegue(withIdentifier: "doneRegister", sender: self)
                self.save()
            }
            let action2 = UIAlertAction(title: "Check again",style : .default, handler: nil)
            alert.addAction(action1)
            alert.addAction(action2)
            present(alert, animated: true, completion: nil)
            
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
    private let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    private let user = [Usersinfo]()
    
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
    
//MARK: -  pickerView
private var picker = UIPickerView()
private let frequencyArray = ["0 /week","1~3 /week","3~5 /week","5~7 /week"]
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
//MARK: - constraints
extension RegisterViewController {
    func setupView(){
        titleStack.snp.makeConstraints { (make) in
            titleStack.translatesAutoresizingMaskIntoConstraints = false
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(view.frame.height/20)
            make.left.equalTo(self.view.snp.left).offset(view.frame.height/20)
            make.right.equalTo(self.view.snp.right).offset(-view.frame.height/20)
        }
        textFieldStack.snp.makeConstraints { (make) in
            textFieldStack.translatesAutoresizingMaskIntoConstraints = false
            textFieldStack.spacing = view.frame.height/20
            make.top.equalTo(titleStack.snp.bottom).offset(view.frame.height/20)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
        }
        doneButton.snp.makeConstraints { (make) in
            doneButton.translatesAutoresizingMaskIntoConstraints = false
            doneButton.layer.cornerRadius = 20
            make.height.equalTo(view.snp.height).multipliedBy(0.07)
            make.width.equalTo(view.snp.width).multipliedBy(0.5)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(trainFrequency.snp.bottom).offset(view.frame.height/20)
        }
    }
    
}
