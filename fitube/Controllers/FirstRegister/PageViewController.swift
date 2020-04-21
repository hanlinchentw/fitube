//
//  PageViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/20.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       imageView.image = UIImage(named: "fitness1")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? ContainerViewController{
            pageViewController.pageViewControllerDelegate = self
        }
    }

}
extension PageViewController : PageViewControllerDelegate{
    func pageViewController(_ pageViewController: ContainerViewController, didUpdateNumberOfPage numberOfPage: Int) {
        self.pageControl.numberOfPages = numberOfPage
    }
    
    func pageViewController(_ pageViewController: ContainerViewController, didUpdatePageIndex pageIndex: Int) {
        self.pageControl.currentPage = pageIndex
    }
    
    
}
