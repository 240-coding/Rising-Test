//
//  AddressManagementViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

protocol AddressRemoveDelegate {
    func removeAddress(addressIdx: String)
}

class AddressManagementViewController: UIViewController {
    
    var addresses = [AddressesResult]()
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight  = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
        
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddressesDataManager().fetchAddressesData(delegate: self)
    }
    
    func configureNavigationBar() {
        navigationBar.tintColor = .black
        navigationBar.backgroundColor = .white

        let item = UINavigationItem()
        let backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(dismissViewController))
        let closeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))

        item.leftBarButtonItem = backBarButtonItem
        item.rightBarButtonItem = closeBarButtonItem

        navigationBar.items = [item]
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    // MARK: - Action
    @objc func dismissViewController() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addAddressButtonTapped() {
        guard let addressAddViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddressAddViewController") as? AddressAddViewController else {
            return
        }
        addressAddViewController.modalPresentationStyle = .fullScreen
        present(addressAddViewController, animated: false, completion: nil)
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        guard let addressEditViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddressEditViewController") as? AddressEditViewController else {
            return
        }
        
        addressEditViewController.address = addresses[sender.tag]
        addressEditViewController.modalPresentationStyle = .fullScreen
        
        present(addressEditViewController, animated: false, completion: nil)
    }
    
    @objc func removeButtonTapped(_ sender: UIButton) {
        guard let addressRemoveViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AddressRemoveViewController") as? AddressRemoveViewController else { return }
        
        addressRemoveViewController.modalPresentationStyle = .overFullScreen
        addressRemoveViewController.delegate = self
        addressRemoveViewController.addressIdx = addresses[sender.tag].addressIdx
        
        present(addressRemoveViewController, animated: false, completion: nil)
    }
    
    @objc func didRemoveAddress() {
        self.viewWillAppear(true)
    }
}

// MARK: - Networking
extension AddressManagementViewController: AddressDataDelegate {
    func didFetchAddressesData(result: [AddressesResult]) {
        addresses = result
        tableView.reloadData()
    }
}

extension AddressManagementViewController: AddressRemoveDelegate {
    func removeAddress(addressIdx: String) {
        AddressesDataManager().deleteAddress(addressIdx: addressIdx, delegate: self)
    }
}

// MARK: - UITableView
extension AddressManagementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressManagementCell") as? AddressManagementTableViewCell else {
            return UITableViewCell()
        }
        
        let address = addresses[indexPath.row]
        
        cell.baseAddressLabel.isHidden = address.isBaseAddress == "Y" ? false : true
        cell.nameLabel.text = address.userName
        cell.addressLabel.text = "\(address.address) \(address.addressDetail)\n\(address.userPhoneNum)"
        
        cell.editButton.tag = indexPath.row
        cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        cell.removeButton.tag = indexPath.row
        cell.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}
