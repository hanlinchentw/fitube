//
//  Container2ViewController.swift
//  fitube
//
//  Created by 陳翰霖 on 2020/4/21.
//  Copyright © 2020 陳翰霖. All rights reserved.
//

import UIKit


protocol PageViewDelegate : class {
    func pageViewController(_ pageViewController: Container2ViewController, didUpdateNumberOfPage numberOfPage: Int)

    func pageViewController(_ pageViewController: Container2ViewController, didUpdatePageIndex pageIndex: Int)
}
class Container2ViewController: UIPageViewController {

    private var viewControllerList: [UIViewController] = [UIViewController]()
    weak var pageViewControllerDelegate: PageViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // 依 storyboard ID 生成 viewController 並加到要用來顯示 pageViewController 畫面的陣列裡
        self.viewControllerList.append(self.getViewController(withStoryboardID: "PageoneViewController"))
        self.viewControllerList.append(self.getViewController(withStoryboardID: "PagetwoViewController"))

        self.delegate = self
        self.dataSource = self
            
            // 設定 pageViewControoler 的首頁
        self.setViewControllers([self.viewControllerList.first!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        
    }
    fileprivate func getViewController(withStoryboardID storyboardID: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
    }

   

}
extension Container2ViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定上一頁的 index
        let priviousIndex: Int = currentIndex - 1
        
        // 判斷上一頁的 index 是否小於 0，若小於 0 則停留在當前的頁數
        return priviousIndex < 0 ? nil : self.viewControllerList[priviousIndex]
    }
    
    /// 下一頁
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - viewController: _
    /// - Returns: _
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 取得當前頁數的 index(未翻頁前)
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定下一頁的 index
        let nextIndex: Int = currentIndex + 1
        
        // 判斷下一頁的 index 是否大於總頁數，若大於則停留在當前的頁數
        return nextIndex > self.viewControllerList.count - 1 ? nil : self.viewControllerList[nextIndex]
    }
    
}
extension Container2ViewController : UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // 取得當前頁數的 viewController
        let currentViewController: UIViewController = (self.viewControllers?.first)!
        
        // 取得當前頁數的 index
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: currentViewController)!
        
        // 設定 RootViewController 上 PageControl 的頁數
        self.pageViewControllerDelegate?.pageViewController(self, didUpdatePageIndex: currentIndex)
    }
}
