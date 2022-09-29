//
//  CategoryViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categories = [CategoryResult]()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()

        tableView.delegate = self
        tableView.dataSource = self
        
        WriteDataManager().fetchCategories(delegate: self)
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
// MARK: - Networking
extension CategoryViewController {
    func didFetchCategoryData(result: [CategoryResult]) {
        categories = result
        tableView.reloadData()
    }
}

// MARK: - UITableView
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        let category = categories[indexPath.row]
        
        cell.nameLabel.text = category.categoryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let categoryOptionViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CategoryOptionViewController") as? CategoryOptionViewController else {
            return
        }
        categoryOptionViewController.category = categories[indexPath.row]
        navigationController?.pushViewController(categoryOptionViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
