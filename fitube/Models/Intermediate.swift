//
//  Intermediate.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/19.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import Foundation
struct Intermediate {
    let day : Int
    
    var trainday  :Int {day%7}
    
    func trainingPart() -> [String]{
        switch trainday {
        case 0:
            return ["Chest workout", "Dumbbell press", "Machine chest fly","Dumbbell incline press","Bench press"]
        case 1:
            return ["Back workout","Lat pull down","Dumbbell row","Machine row","Seated-row"]
        case 2:
            return ["Leg workout", "Squat", "Lunge", "Leg extension","Leg press"]
        case 3:
            return ["Shoulder workout", "Dumbbell shoulder press", "Dumbbell lateral raise",
                    "Dumbbell front raise","Machine rear delt fly"]
        case 4:
            return ["Arm workout","Dumbbell bicep curl","EZ-bar curl","Overhead tricep extension", "Tricep cable push down"]
        default:
            return ["rest day"]
        }
    }
}
