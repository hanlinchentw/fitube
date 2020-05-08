//
//  PopUpViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/18.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var exerciseTabelView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    lazy fileprivate var bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1785352826, green: 0.2611154318, blue: 0.3822084665, alpha: 1)
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.borderWidth = 5
        return view
    }()
    lazy fileprivate var dayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Day\n\(self.defaults.integer(forKey:"passedDay")+1)"
        return label
    }()
    lazy fileprivate var setsLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "4\nsets"
        return label
    }()
    lazy fileprivate var repsLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "8 ~ 12\nreps"
        return label
    }()
    
    
    fileprivate var defaults = UserDefaults.standard
    var trainingNote :[String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        exerciseTabelView.dataSource = self
        exerciseTabelView.delegate = self

    }

    @IBAction func headToBusinessButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingNote!.count-1
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
extension PopUpViewController{
    fileprivate func setupView(){
        exerciseTabelView.rowHeight = view.frame.height/8
        exerciseTabelView.backgroundColor = #colorLiteral(red: 0.1785352826, green: 0.2611154318, blue: 0.3822084665, alpha: 1)
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = trainingNote![0]

        navigationController?.navigationBar.tintColor = .black
        
        view.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
            dayLabel.textColor = .white
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(40)
        }
        view.addSubview(setsLabel)
        setsLabel.snp.makeConstraints { (make) in
            setsLabel.translatesAutoresizingMaskIntoConstraints = false
            setsLabel.textColor = .white
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        view.addSubview(repsLabel)
        repsLabel.snp.makeConstraints { (make) in
            repsLabel.translatesAutoresizingMaskIntoConstraints = false
            repsLabel.textColor = .white
            make.top.equalToSuperview().offset(40)
            make.right.equalTo(view).offset(-40)
        }
    
        exerciseTabelView.snp.makeConstraints { (make) in
            exerciseTabelView.translatesAutoresizingMaskIntoConstraints = false
            make.left.right.equalToSuperview()
            make.top.equalTo(setsLabel).offset(view.frame.height/8)
            make.centerY.equalToSuperview().offset(200)
            
        }
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            bottomView.translatesAutoresizingMaskIntoConstraints = false
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        startButton.layer.borderWidth = 5
        startButton.backgroundColor = #colorLiteral(red: 0.02102893405, green: 0.5583514571, blue: 0.3434379995, alpha: 1)
        startButton.layer.cornerRadius = 30
        NSLayoutConstraint(item: startButton!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.6, constant: 0).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: view.frame.height/20).isActive = true
        NSLayoutConstraint(item: startButton!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    }
    @objc private func backButtonPressed(sender:UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
}
