//
//  TabManViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/24.
//

import UIKit
import Tabman
import Pageboy

class TabManViewController: TabmanViewController {
    
    var viewControllers = [UIViewController]()
    var homeData = [HomeData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers()
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .leading
        bar.layout.contentMode = .intrinsic
        bar.layout.interButtonSpacing = 24
        
        bar.backgroundView.style = .clear
        bar.backgroundColor = .white
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10)
        
        bar.buttons.customize { button in
            button.tintColor = UIColor(named: "gray")
            button.selectedTintColor = .black
            button.font = .boldSystemFont(ofSize: 17)
        }
        bar.indicator.weight = .custom(value: 3)
        bar.indicator.cornerStyle = .rounded
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.tintColor = .black

        addBar(bar, dataSource: self, at: .top)
        
    }
    
    override func loadView() {
        super.loadView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !viewControllers.isEmpty {
            guard let recommendViewController = viewControllers[0] as? RecommendViewController else {
                return
            }
            recommendViewController.homeData = self.homeData
            recommendViewController.viewWillAppear(true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    func setViewControllers() {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let recommendViewController = storyboard.instantiateViewController(withIdentifier: "RecommendViewController") as? RecommendViewController, let brandViewController = storyboard.instantiateViewController(withIdentifier: "BrandViewController") as? BrandViewController else {
            return
        }
        viewControllers = [recommendViewController, brandViewController]
    }
}

extension TabManViewController: TMBarDataSource, PageboyViewControllerDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "추천상품")
        case 1:
            return TMBarItem(title: "브랜드")
        default:
            return TMBarItem(title: "")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
