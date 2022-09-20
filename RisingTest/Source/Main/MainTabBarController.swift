//
//  MainTabBarController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/20.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[1] {
            guard let searchViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
                return true
            }
            searchViewController.modalPresentationStyle = .fullScreen
            present(searchViewController, animated: true)
            return false
        } else if viewController == tabBarController.viewControllers?[2] {
            let writeViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "WriteNavigationController")
            writeViewController.modalPresentationStyle = .fullScreen
            present(writeViewController, animated: true)
            return false
        }
        return true
    }
}
