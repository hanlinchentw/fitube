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
    
    let frequencyArray = ["0 /week","1~3 /week","3~5 /week","5~7 /week"]
    var picker = UIPickerView()
    
    let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let user = [Usersinfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 10
        print (filePath)
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
        let newUser = Usersinfo(context: contexts)
        if let namee = nameTextField.text, let age = Int32(ageTextField.text!),
            let height = Double(heightTextField.text!), let weight = Double(weightTextField.text!),
            let trFrequency = trainFrequency.text{
                newUser.name = namee
                newUser.age = age
                newUser.height = height
                newUser.weight = weight
                newUser.frequency = trFrequency
                
//                performSegue(withIdentifier: "doneRegister", sender: self)
                save()
        }else{
            let alert = UIAlertController(title: "Info. incomplete", message: "Your information is incomplete.", preferredStyle: .alert)
            let action = UIAlertAction()
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            print("nil")
        }
//        UserDefaults.standard.set(true, forKey: "ALLREADY_REGISTER")
    }
    
    
    //MARK: - Data manipulation Method
    func save(){
        do{
//            deleteAllData(entity: "Users")
            try contexts.save()
        }catch{
            print("Save error:\(error)")
        }
    }
    func deleteAllData(entity: String)
    {
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity )
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try contexts.execute(DelAllReqVar) }
        catch { print(error) }
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
