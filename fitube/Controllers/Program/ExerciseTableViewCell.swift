//
//  ExerciseTableViewCell.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/26.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var exerciseLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
