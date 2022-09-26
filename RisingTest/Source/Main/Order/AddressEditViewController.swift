//
//  AddressEditViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/27.
//

import UIKit
import TextFieldEffects

class AddressEditViewController: UIViewController {
    
    var isBaseAddress = false
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameTextField: UITextField!
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
    }
    
    // MARK: - Action
    @objc func dismissViewController() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func baseAddressViewTapped() {
        isBaseAddress.toggle()
        configureBaseAddressComponents()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        print("주소 저장")
        dismiss(animated: false, completion: nil)
    }
}
