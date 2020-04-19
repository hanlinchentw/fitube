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
    
    var levelDetectors = levelDetector()
    private let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var levels = [UsersLevel]()
    
    var levelDetect = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in levelButton{
            button.backgroundColor = .gray
            button.layer.cornerRadius = 10
        }
    
        load()
//        let userLevelDetected = Int(levels[0].level)
        levelButton[levelDetect-1].backgroundColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
    }
    @IBAction func levelBurrtonPressed(_ sender: UIButton) {
        let eagle = UsersLevel(context:contexts)
        if sender.backgroundColor ==  #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1) {
            print(sender.currentTitle!)
            switch sender.currentTitle! {
            case levelButton[0].currentTitle:
                eagle.level = 1
                eagle.levelDescription = levelButton[0].currentTitle
            case levelButton[1].currentTitle:
                eagle.level = 2
                eagle.levelDescription = levelButton[1].currentTitle
            case levelButton[2].currentTitle:
                eagle.level = 3
                eagle.levelDescription = levelButton[2].currentTitle
            case levelButton[3].currentTitle:
                eagle.level = 4
                eagle.levelDescription = levelButton[3].currentTitle
            default:
                fatalError()
            }
        }else{
            eagle.level = Int32(levelDetect)
            eagle.levelDescription = levelButton[levelDetect-1].currentTitle
        }
        save()
        performSegue(withIdentifier: "levelDetermined", sender: self)
       
    }
    
    func save(){
        do{
            deleteAllData(entity: "UsersLevel")
            try contexts.save()
        }catch{
            fatalError()
        }
    }
    
    func load(){
        levelDetect = levelDetectors.levelUpdate()
        let request :NSFetchRequest<UsersLevel> = UsersLevel.fetchRequest()
        do {
            self.levels =  try contexts.fetch(request)
        }catch{
            fatalError("fetch user data error:\(error)")
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
