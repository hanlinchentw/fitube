//
//  Advanced.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/19.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import Foundation
struct Advanced {
    let day : Int

    var trainday  :Int {day%7}

    func trainingPart() -> [String]{
        switch trainday {
        case 0,4:
            return ["Chest & Tricep", "Dumbell press", "Cable chest fly","Dumbell incline press","Bench press",
                    "Skull crushers","Overhead tricep extension","Tricep cable push down"]
        case 1,5:
            return ["Back & Bicep","Lat pull down","Bent-over row","Dumbell row","Machine row","Straight-arm pull dowm",
                    "EZ-bar curl","Dumbell curl","Hammer curl"]
        case 2:
            return ["Leg & Abs", "Squat","Leg press","Lunge", "Leg extension","Hamstring curl",
                    "Hang leg raise","Weighted-crunch"]
        case 3:
            return ["Shoulder & Upper chest", "Incline bench press","Dumbell shoulder press", "Dumbell lateral raise",
                    "Shoulder press","Front raise","Machine rear delt fly"]
        default:
            return ["rest day"]
        }
    }
}

