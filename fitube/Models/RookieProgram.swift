//
//  RookieProgram.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/17.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import Foundation
struct RookieProgram {
    let day : Int
    
    var trainday  :Int {day%7}
    
    func trainingPart() -> [String]{
        switch trainday {
        case 0:
            return ["Chest day", "Dumbbell press", "Machine chest fly","Dumbell incline press"]
        case 2:
            return ["Leg day", "Squat", "Lunge", "leg extension"]
        case 4:
            return ["Back day","Lat pull down","Dumbbell row","Machine row"]
        default:
            return ["rest day"]
        }
    }
}
