//
//  SearchViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    let childViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchChildViewController")
    let resultChildViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchResultChildViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNavigationBar()
        
        addChild(childViewController)
        addChild(resultChildViewController)
        self.view.addSubview(childViewController.view)
        self.view.addSubview(resultChildViewController.view)
        
        childViewController.didMove(toParent: self)
        resultChildViewController.didMove(toParent: self)
        
        childViewController.view.frame = self.view.bounds
        resultChildViewController.view.frame = self.view.bounds
        resultChildViewController.view.isHidden = true
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(dismissViewController))
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "house"), style: .plain, target: self, action: #selector(pressHomeButton))
        
        let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            
            searchBar.placeholder = "검색어를 입력해주세요"
            searchBar.setImage(UIImage(), for: .search, state: .normal)
            searchBar.searchTextField.font = .boldSystemFont(ofSize: 14)
            
            return searchBar
        }()
        
        searchBar.delegate = self
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.titleView = searchBar
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pressHomeButton() {
        if let tabBar = presentingViewController as? UITabBarController {
            tabBar.selectedIndex = 0
        }
        self.dismiss(animated: true, completion: nil)
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
            if text.isEmpty {
                childViewController.view.isHidden = false
                resultChildViewController.view.isHidden = true
            } else {
                childViewController.view.isHidden = true
                resultChildViewController.view.isHidden = false
            }
        }
    }
}
