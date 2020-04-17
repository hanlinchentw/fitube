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
        case 1:
            return ["Chest day", "Dumbell press", "Machine chest fly","Dumbell incline press"]
        case 3:
            return ["Leg day", "Squat", "Lunge", "leg extension"]
        case 5:
            return ["Back day","Lat pull down","Dumbell row","Machine row"]
        default:
            return ["rest day"]
        }
    }
}
