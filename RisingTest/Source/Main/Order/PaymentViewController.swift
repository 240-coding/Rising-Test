//
//  PaymentViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class PaymentViewController: UIViewController {
    
    var selectedIndex = 2
    var delegate: SelectPaymentDelegate?
    let paymentName = ["신용/체크카드", "카카오페이", "네이버페이", "페이코", "토스", "간편계좌결제", "휴대폰결제", "편의점결제", "무통장(가상계좌)", "차이"]
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var payments: [UIView]!
    @IBOutlet var checkImageViews: [UIImageView]!
    @IBOutlet var applyButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        applyButton.layer.cornerRadius = 5
        focusSelectedPayment(selectedIndex: selectedIndex)
        configureNavigationBar()
        initTapGesture()
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
    
    func focusSelectedPayment(selectedIndex: Int) {
        for (index, view) in payments.enumerated() {
            view.layer.cornerRadius = 5
            view.clipsToBounds = true
            view.layer.borderWidth = selectedIndex == index ? 2 : 1
            view.layer.borderColor = selectedIndex == index ? UIColor(named: "red")?.cgColor : UIColor(named: "lightgray")?.cgColor
        }
        
        for (index, imageView) in checkImageViews.enumerated() {
            imageView.tintColor = selectedIndex == index ? UIColor(named: "red") : UIColor(named: "lightgray")
        }
    }
    
    func initTapGesture() {
        payments.forEach { view in
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectPayment))
            view.addGestureRecognizer(tap)
        }
    }
    
    // MARK: - Actions
    @objc func dismissViewController() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func selectPayment(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view, let selectedViewIndex = payments.firstIndex(of: view) {
            selectedIndex = selectedViewIndex
            focusSelectedPayment(selectedIndex: selectedViewIndex)
        }
    }
    
    @IBAction func appyButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            self.delegate?.setSelectedPayment(paymentName: self.paymentName[self.selectedIndex])
        })
    }
    
}
