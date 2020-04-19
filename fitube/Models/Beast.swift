//
//  Beast.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/19.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import Foundation

struct Beast {
    let day : Int

    var trainday  :Int {day%7}

    func trainingPart() -> [String]{
        switch trainday {
        case 0:
            return ["Chest & Tricep",
                    "Bench press","Inclne bench press", "Cable chest fly (Dropset)",
                    "Hammer decline press Superset with Single-Arm (Dropweight)",
                    "Skull crushers","dips","Overhead tricep extension","Tricep push down (Dropset)"]
        case 1:
            return ["Back & Bicep",
                    "Lat pull down Superset with wide-grip (Dropset)","Seated cable row",
                    "Dumbell row (Dropset)","Single arm Hammer Front Lat Pull Down",
                    "Straight-arm pull dowm","Dumbell curl (Dropset)","Hammer curl","Cable curl"]
        case 2:
            return ["Leg day",
                    "Squat","Leg press","Deadlift", "Leg extension","Hamstring curl","Lunge"]
        case 3:
            return ["Shoulder & Abs",
                    "Dumbell shoulder press", "Dumbell lateral raise Superset with Upright row",
                    "Shoulder press Superset with Front raise","Machine rear delt fly","Hanged leg raise","Weighted-Crunch"]
        case 4:
            return ["Back & Rear delt",
                    "Lat pull down","Wide-griped cable row (Dropset)","Bent over row",
                    "Hammer row machine Superset with sigle arm (Dropweight)","Single-Arm Hammer DY row",
                    "Face pull","Machine rear delt flt","Dumbell rear delt fly"]
        case 5:
            return ["Chest & Shoulder",
                    "Dumbell press", "Dumbell incline press","Cable chest fly (Dropset)",
                    "Hammer incline press Superset with Single-Arm (Dropweight)",
                    "Hammer shoulder press Superset with Front raise","Dumbell lateral raise Superset with Upright row"]
        case 6:
            return ["Arm & Abs",
                    "EZ-bar curl Superset with Dumbell curl","Hammer curl","Cable curl(Dropset)",
                    "Preacher curl","Close-griped bench press","Skull crushers","Overhead tricep extension (Dropset)",
                    "Tricep push dowm (Dropset)","Hanged leg raise","Weighted crunch"]
        default:
            return ["rest day"]
        }
    }
}
