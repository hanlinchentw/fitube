//
//  RookieProgram.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import Foundation
struct Beginner {
    let day : Int
    
    var trainday  :Int {day%7}
    
    func trainingPart() -> [String]{
        switch trainday {
        case 0:
            return ["Chest workout", "Dumbbell press", "Machine chest fly","Dumbell incline press"]
        case 2:
            return ["Leg workout", "Squat", "Lunge", "leg extension"]
        case 4:
            return ["Back workout","Lat pull down","Dumbbell row","Machine row"]
        default:
            return ["rest day"]
        }
    }
}
