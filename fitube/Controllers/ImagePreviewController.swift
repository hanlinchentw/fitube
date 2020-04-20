//
//  ImagePreviewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/20.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit
import  CoreData

protocol whatUserTrain {
    func fetchTrainingProgram() -> [String]
}

class ImagePreviewController: UIViewController{
    


    @IBOutlet weak var exercisesLabel: UILabel!
    @IBOutlet weak var imageShownView: UIImageView!
    
    var image : UIImage?

    var delegate : whatUserTrain?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let trainingpart = delegate?.fetchTrainingProgram()
        imageShownView.image = self.image
        exercisesLabel.text = ""
        if let part = trainingpart{
            for n in 1 ... (part.count-1){
                exercisesLabel.text?.append("\(part[n])\n")
            }
        }
        
    }


   

}
