//
//  levelDetector.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import CoreData
struct levelDetector {
    private let contexts = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var userData = [Usersinfo]()
    private var userTrain = [UsersLevel]()
    
    mutating func levelUpdate(){
        var levelDetected = self.levelDetector()
        var newLevel = UsersLevel(context:contexts)
        
        switch levelDetected {
            case 5...7:
                newLevel.level = 1
                newLevel.levelDescription = "Rookie"
            case 8...10:
                newLevel.level = 2
                newLevel.levelDescription = "Intermediate"
            case 11:
                newLevel.level = 3
                newLevel.levelDescription = "Advanced"
            default:
                newLevel.level = 4
                newLevel.levelDescription = "Beast"
            }
        do{
            deleteAllData(entity: "UsersLevel")
            try contexts.save()
        }catch{
            fatalError()
        }
    }
    
    mutating func levelDetector() -> Double{
        self.loadUserInfo()
        let trFrequency = userData[0].frequency
        let weight = userData[0].weight
        let height = userData[0].height
        let bmi = weight/pow(height/100, 2)
        let age = userData[0].age
        var score = 0.0
        switch trFrequency {
            case "0 /week":
                score  += 1
            case "1~3 /week":
                score  += 2
            case "3~5 /week":
                score  += 3
            case "5~7 /week":
                score  += 4
            default:
                score  += 0
        }
        
        switch bmi {
            case 0...17:
                score  += 1
            case 18...24:
                score  += 3
            case 25...30:
                score  += 2
            case 30...50:
                score  += 1
            default:
                score  += 0
        }
        
        switch age {
            case 0...14:
                score  += 2
            case 15...30:
                score  += 4
            case 31...45:
                score  += 3
            case 46...100:
                score  += 1
            default:
                score  += 0
        }
        return score
    }
    
    
    mutating func loadUserInfo() {
        let request :NSFetchRequest<Usersinfo> = Usersinfo.fetchRequest()
        do {
            self.userData =  try contexts.fetch(request)
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