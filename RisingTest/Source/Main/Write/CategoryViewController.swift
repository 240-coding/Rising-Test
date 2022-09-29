//
//  CategoryViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureNavigationBar() {
        let backBarButtom = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popVC))
        let titleBarButton = UIBarButtonItem(title: "카테고리", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItems = [backBarButtom, titleBarButton]
    }
    
    // MARK: - Action
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = "카테고리"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
