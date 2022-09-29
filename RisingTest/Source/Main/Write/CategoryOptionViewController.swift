//
//  CategoryOptionViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class CategoryOptionViewController: UIViewController {
    
    var category: CategoryResult?
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()

        tableView.delegate = self
        tableView.dataSource = self
        
        if let header = tableView.tableHeaderView as? CategoryOptionHeaderView {
            header.optionLabel.text = category?.categoryName ?? ""
            header.allButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        }
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

// MARK: - UITableView
extension CategoryOptionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.options.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryOptionCell") as? CategoryOptionTableViewCell else {
            return UITableViewCell()
        }
        if let category = category {
            cell.nameLabel.text = category.options[indexPath.row].categoryOptionName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let category = category {
            NotificationCenter.default.post(name: Notification.Name.category, object: nil, userInfo: [
                "categoryIdx": String(category.categoryIdx),
                "categoryOptionIdx": String(category.options[indexPath.row].categoryOptionIdx),
                "categoryName": category.categoryName,
                "categoryOptionName": category.options[indexPath.row].categoryOptionName
            ])
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
}
