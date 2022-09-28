//
//  OrderCompleteViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class OrderCompleteViewController: UIViewController {
    
    var orderIdx: Int?
    var paymentMethod: String?
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var orderCompleteLabel: UILabel!
    @IBOutlet var checkOrderDetailButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        if let paymentMethod = paymentMethod {
            orderCompleteLabel.text = "\(paymentMethod)로\n결제가 완료되었습니다"
        }
        
        checkOrderDetailButton.layer.cornerRadius = 5
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
    
    // MARK: - Actions
    @objc func dismissViewController() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func checkOrderDetailButtonTapped() {
        if let orderIdx = orderIdx {
            print(orderIdx)
        }
        print("상세내역 보기")
    }

}
