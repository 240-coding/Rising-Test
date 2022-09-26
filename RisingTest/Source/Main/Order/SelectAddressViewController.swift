//
//  SelectAddressViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class SelectAddressViewController: UIViewController {
    
    var addresses = [AddressesResult]()
    
    var delegate: SelectAddressDelegate?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "주소 선택"
        
        let editBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: nil)
        let closeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItems = [closeBarButtonItem, editBarButtonItem]
    }
    
    // MARK: - Actions
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableView
extension SelectAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectAddressCell") as? AddressSelectTableViewCell else {
            return UITableViewCell()
        }
        
        
        if indexPath.row == 0 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        
        let address = addresses[indexPath.row]
        
        cell.baseAddressLabel.isHidden = address.isBaseAddress == "Y" ? false : true
        cell.addressLabel.text = "\(address.address) \(address.addressDetail)"
        cell.nameLabel.text = address.userName
        cell.phoneLabel.text = address.userPhoneNum
        cell.addressLabelTrailing.constant = cell.baseAddressLabel.isHidden ? 8 : cell.baseAddressLabel.frame.width + 8 + 8
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.setSelectedAddress(index: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
}
