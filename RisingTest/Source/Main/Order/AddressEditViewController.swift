//
//  AddressEditViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/27.
//

import UIKit
import TextFieldEffects

class AddressEditViewController: UIViewController {
    
    var address: AddressesResult?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailAddressTextField: UITextField!
    
    @IBOutlet weak var baseAddressView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var baseAddressLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTextFields()
        configureBaseAddressComponents()
        configureBaseAddressView()
        configureDoneButton()
    }
    
    // MARK: - Configure UI
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
    
    func configureTextFields() {
        nameTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        addressTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        detailAddressTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)

        guard let address = address else {
            return
        }
        nameTextField.text = address.userName
        phoneTextField.text = address.userPhoneNum
        addressTextField.text = address.address
        detailAddressTextField.text = address.addressDetail
    }
    
    func configureBaseAddressComponents() {
        guard let isBaseAddress = address?.isBaseAddress else { return }
        
        if isBaseAddress == "Y" {
            checkImageView.tintColor = UIColor(named: "red")
            baseAddressLabel.textColor = .black
        } else {
            checkImageView.tintColor = UIColor(named: "lightgray")
            baseAddressLabel.textColor = UIColor(named: "gray")
        }
    }
    
    func configureBaseAddressView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(baseAddressViewTapped))
        baseAddressView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureDoneButton() {
        doneButton.layer.cornerRadius = 5
        doneButton.backgroundColor = doneButton.isEnabled ? UIColor(named: "red") : UIColor(named: "lightred")
    }
    
    func checkDoneButtonIsEnabled() {
        doneButton.isEnabled = areTextFieldsTextExists()
        doneButton.backgroundColor = doneButton.isEnabled ? UIColor(named: "red") : UIColor(named: "lightred")
    }
    
    func areTextFieldsTextExists() -> Bool {
        if let name = nameTextField.text, let phone = phoneTextField.text, let userAddress = addressTextField.text, let addressDetail = detailAddressTextField.text {
            return name.isExists && phone.isExists && userAddress.isExists && addressDetail.isExists ? true : false
        } else {
            return false
        }
    }
    
    // MARK: - Action
    @objc func dismissViewController() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func textFieldValueChanged() {
        checkDoneButtonIsEnabled()
    }
    
    @objc func baseAddressViewTapped() {
        guard let isBaseAddress = address?.isBaseAddress else { return }
        address?.isBaseAddress = isBaseAddress == "Y" ? "N" : "Y"
        configureBaseAddressComponents()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if let addressIdx = address?.addressIdx, let name = nameTextField.text, let phone = phoneTextField.text, let userAddress = addressTextField.text, let detailAddress = detailAddressTextField.text, let isBaseAddress = address?.isBaseAddress {
            let parameters = AddressEditRequest(userName: name, userPhoneNum: phone, address: userAddress, addressDetail: detailAddress, isBaseAddress: isBaseAddress)
            
            AddressesDataManager().patchAddress(addressIdx: String(addressIdx), parameters: parameters, delegate: self)
        }
    }
}

// MARK: - Networking
extension AddressEditViewController {
    func didPatchAddress() {
        dismiss(animated: false, completion: nil)
    }
}
