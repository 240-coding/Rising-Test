//
//  AddressAddViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/27.
//

import UIKit
import TextFieldEffects

class AddressAddViewController: UIViewController {
    
    var address = NewAddressRequest(userName: "", userPhoneNum: "", address: "", addressDetail: "", isBaseAddress: "N")
    var isBaseAddress = false
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailAddressTextField: UITextField!
    
    @IBOutlet weak var baseAddressView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var baseAddressLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardWhenTappedAround()

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
    }
    
    func configureBaseAddressComponents() {
        if isBaseAddress {
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
        doneButton.isEnabled = false
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
        isBaseAddress.toggle()
        configureBaseAddressComponents()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if let name = nameTextField.text, let phone = phoneTextField.text, let userAddress = addressTextField.text, let addressDetail = detailAddressTextField.text {
            let parameters = NewAddressRequest(userName: name, userPhoneNum: phone, address: userAddress, addressDetail: addressDetail, isBaseAddress: isBaseAddress ? "Y" : "N")
            AddressesDataManager().postNewAddress(parameters: parameters, delegate: self)
        }
    }
}

// MARK: - Networking
extension AddressAddViewController {
    func didPostAddress() {
        dismiss(animated: true, completion: nil)
    }
}
