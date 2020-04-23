//
//  NoteforUser.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/19.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import Foundation
struct NoteforUser {
    let quote = ["Weights is not the point, feeling is",
                 "Movement should be under control, rather swing",
                 "Rest between sets shouldn't be too long. (60 sec recomended)",
                 "Put your ego outside the Gym","Eat good food. Leave the temptaion",
                 "Patience makes extraordinary",
                 "STOP if any unconfortable",
                 "“Two things are infinite: the universe and human stupidity; and I'm not sure about the universe.”― Albert Einstein",
                 "“Life is like riding a bicycle. To keep your balance, you must keep moving.”― Albert Einstein",
                 "“Anyone who has never made a mistake has never tried anything new.”― Albert Einstein",
                 "“You never fail until you stop trying.”― Albert Einstein",
                 "“Everything must be made as simple as possible. But not simpler.”― Albert Einstein",
                 "“Insanity is doing the same thing over and over and expecting different results.”― Albert Einstein"]
    func notefromDeveloper() ->String{
        return quote[Int.random(in: 0...11)]
    }
}
