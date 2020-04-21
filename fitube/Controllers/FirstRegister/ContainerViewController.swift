import UIKit


protocol PageViewControllerDelegate: class {
    /// 設定頁數
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - numberOfPage: _
    func pageViewController(_ pageViewController: ContainerViewController, didUpdateNumberOfPage numberOfPage: Int)
    
    /// 當 pageViewController 切換頁數時，設定 pageControl 的頁數
    ///
    /// - Parameters:
    ///   - pageViewController: _
    ///   - pageIndex: _
    func pageViewController(_ pageViewController: ContainerViewController, didUpdatePageIndex pageIndex: Int)
}

class ContainerViewController: UIPageViewController {

    private var viewControllerList: [UIViewController] = [UIViewController]()
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 依 storyboard ID 生成 viewController 並加到要用來顯示 pageViewController 畫面的陣列裡
        self.viewControllerList.append(self.getViewController(withStoryboardID: "FirstPageViewController"))
        self.viewControllerList.append(self.getViewController(withStoryboardID: "SecondPageViewController"))
        self.viewControllerList.append(self.getViewController(withStoryboardID: "ThirdPageViewController"))
        self.viewControllerList.append(self.getViewController(withStoryboardID: "FourPageViewController"))
        
        self.delegate = self
        self.dataSource = self
        
        // 設定 pageViewControoler 的首頁
        self.setViewControllers([self.viewControllerList.first!], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
    
    fileprivate func getViewController(withStoryboardID storyboardID: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
    }

}

extension ContainerViewController : UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentViewController: UIViewController = (self.viewControllers?.first)!
        
        // 取得當前頁數的 index
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: currentViewController)!
        
        // 設定 RootViewController 上 PageControl 的頁數
        self.pageViewControllerDelegate?.pageViewController(self, didUpdatePageIndex: currentIndex)
    }
}

extension ContainerViewController :UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定上一頁的 index
        let priviousIndex: Int = currentIndex - 1
        
        // 判斷上一頁的 index 是否小於 0，若小於 0 則停留在當前的頁數
        return priviousIndex < 0 ? nil : self.viewControllerList[priviousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int =  self.viewControllerList.firstIndex(of: viewController)!
        
        // 設定下一頁的 index
        let nextIndex: Int = currentIndex + 1
        
        // 判斷下一頁的 index 是否大於總頁數，若大於則停留在當前的頁數
        return nextIndex > self.viewControllerList.count - 1 ? nil : self.viewControllerList[nextIndex]
    }
    
    
}
