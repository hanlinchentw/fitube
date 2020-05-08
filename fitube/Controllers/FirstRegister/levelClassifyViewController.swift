//
//  levelClassifyViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import  CoreData
class levelClassifyViewController: UIViewController {

    @IBOutlet var levelButton: [UIButton]!
    @IBOutlet weak var assessmentLabel: UILabel!
    
    var levelDetectors = levelDetector()
    private let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var levelDetect = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    
        levelDetect = levelDetectors.levelUpdate()

        assessmentLabel.text = "Recommended program: \(levelButton[levelDetect-1].currentTitle!)"
        
        levelButton[levelDetect-1].backgroundColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
         let alert = UIAlertController(title: "Assessment", message: "Level: \(levelButton[levelDetect-1].currentTitle!)", preferredStyle: .alert)
         let action = UIAlertAction(title: "OK", style: .default, handler: nil)
         alert.addAction(action)
         present(alert, animated: true, completion: nil)
    }
    var temp  = 0
    @IBAction func levelBurrtonPressed(_ sender: UIButton) {
        let eagle = UsersLevel(context:contexts)
        
        if sender.backgroundColor == .gray{
            let alert = UIAlertController(title: "Not the recommendation!", message: "Step by step is key of success.", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "I don't mind", style: .default) { _ in
                switch sender {
                case self.levelButton[0]:
                    self.temp = 0
                    eagle.level = 1
                    eagle.levelDescription = self.levelButton[0].currentTitle
                case self.levelButton[1]:
                    self.temp = 1
                    eagle.level = 2
                    eagle.levelDescription = self.levelButton[1].currentTitle
                case self.levelButton[2]:
                    self.temp = 2
                    eagle.level = 3
                    eagle.levelDescription = self.levelButton[2].currentTitle
                case self.levelButton[3]:
                    self.temp = 3
                    eagle.level = 4
                    eagle.levelDescription = self.levelButton[3].currentTitle
                default:
                    fatalError()
                }
                self.performSegue(withIdentifier: "levelDetermined", sender: self)
                self.save()
            }
            let action2 = UIAlertAction(title: "Wrong click", style: .default, handler: nil)
            alert.addAction(action1)
            alert.addAction(action2)
            present(alert, animated: true, completion: nil)
            
        }else{
            self.temp = levelDetect - 1
            eagle.level = Int32(levelDetect)
            eagle.levelDescription = levelButton[levelDetect-1].currentTitle
            save()
            performSegue(withIdentifier: "levelDetermined", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "levelDetermined"{
            let destination = segue.destination as? ListViewController
            destination!.levelSend = levelButton[temp].currentTitle
        }
    }
//MARK: - Core data management
    
    func save(){
        do{
            deleteAllData(entity: "UsersLevel")
            try contexts.save()
        }catch{
            fatalError()
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

//MARK: - constraints
extension levelClassifyViewController{
    
    func setupView(){
        for button in levelButton{
            button.backgroundColor = .gray
            button.layer.cornerRadius = 10
            button.snp.makeConstraints { (make) in
                make.width.equalTo(view.snp.width).multipliedBy(0.8)
                make.centerX.equalTo(view.snp.centerX)
            }
        }
    }
}
