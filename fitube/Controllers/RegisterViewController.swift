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
    let frequencyArray = ["0/week","1~3/week","3~5/week","5~7/week"]
    var picker = UIPickerView()
    
    let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print (filePath)
        picker.dataSource = self
        picker.delegate = self
        trainFrequency.inputView = picker
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func closeKeyboard(){
    self.view.endEditing(true)
    }
    @IBAction func DoneButtonPressed(_ sender: UIButton) {
        let newUser = User(context: contexts)
        newUser.name = nameTextField.text
        newUser.age = ageTextField.text
        newUser.height = heightTextField.text
        newUser.weight = weightTextField.text
        newUser.frequency = trainFrequency.text
        
        save()
        UserDefaults.standard.set(true, forKey: "ALLREADY_REGISTER")
    }
    
    
    //MARK: - Data manipulation Method
    func save(){
        do{
            try contexts.save()
        }catch{
            print("Save error:\(error)")
        }
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
