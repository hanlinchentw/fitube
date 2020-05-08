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
        self.backgroundColor = #colorLiteral(red: 0.1785352826, green: 0.2611154318, blue: 0.3822084665, alpha: 1)
        self.tintColor = .white
        self.textLabel?.textColor = .white
        exerciseImage.snp.makeConstraints { (make) in
            exerciseImage.contentMode = .scaleAspectFill
            exerciseImage.layer.cornerRadius = 10
            make.centerY.equalToSuperview()
            make.height.width.equalTo(self.snp.height).multipliedBy(0.9)
            make.left.equalToSuperview().offset(20)
            
            
        }
        exerciseLabel.snp.makeConstraints { (make) in
            make.left.equalTo(exerciseImage.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

