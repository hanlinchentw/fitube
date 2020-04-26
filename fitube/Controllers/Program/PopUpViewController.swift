import UIKit

class PopUpViewController: UIViewController {

    var trainingNote :[String]?
  
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        exerciseLabel.text = "   Exercise:\n"
        if let exercise = trainingNote {
            titleLabel.text = exercise[0]
            for n in 1...(exercise.count-1){
                exerciseLabel.text?.append("   \(n). \(exercise[n])\n")
            }
            exerciseLabel.text?.append("\n  Total sets : 4\n  Reps: 8 ~ 12")
        }
        exerciseLabel.layer.cornerRadius = 10
        exerciseLabel.layer.borderWidth = 5
        exerciseLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        exerciseLabel.layer.backgroundColor = #colorLiteral(red: 0.2303010523, green: 0.4739870429, blue: 0.7338336706, alpha: 1)
        NSLayoutConstraint(item: exerciseLabel!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: exerciseLabel!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: exerciseLabel!, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.45, constant: 0).isActive = true
        NSLayoutConstraint(item: exerciseLabel!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.9, constant: 0).isActive = true
  

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
    
    

   

}
