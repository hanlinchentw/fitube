//
//  PopUpViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/18.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var trainingNote :[String]?
  
    
    
    @IBOutlet weak var exerciseTabelView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTabelView.dataSource = self
        exerciseTabelView.delegate = self
        exerciseTabelView.rowHeight = view.frame.height/10
        
        
        
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        
       
  

        NSLayoutConstraint(item: titleLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: titleLabel!, attribute: .bottom, relatedBy: .equal, toItem: exerciseLabel , attribute: .top, multiplier: 1, constant: -view.frame.height/10).isActive = true
        
        
        startButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        startButton.layer.borderWidth = 5
        startButton.backgroundColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
        startButton.layer.cornerRadius = 30
        NSLayoutConstraint(item: startButton!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .top, relatedBy: .equal, toItem: exerciseLabel, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        
    }

    @IBAction func headToBusinessButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingNote!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as? ExerciseTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row >= trainingNote!.count-1{
            cell.exerciseImage.image = UIImage(named: trainingNote![indexPath.row])
            cell.exerciseLabel.text = trainingNote![indexPath.row]
        }else{
            cell.exerciseImage.image = UIImage(named: trainingNote![indexPath.row+1])
            cell.exerciseLabel.text = trainingNote![indexPath.row+1]
        }
        
        return cell
    }
    

   

}
