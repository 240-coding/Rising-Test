//
//  SelectReceiptViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class SelectReceiptViewController: UIViewController {
    
    @IBOutlet var receiptButtons: [UIButton]!
    
    var selectedReceiptIndex = 0
    var delegate: SelectReceiptDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiptButtons.forEach { button in
            button.addTarget(self, action: #selector(receiptButtonTapped), for: .touchUpInside)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for (index, button) in receiptButtons.enumerated() {
            if index == selectedReceiptIndex {
                button.tintColor = UIColor(named: "red")
            } else {
                button.tintColor = UIColor(named: "gray")
            }
        }
    }
    
    @objc func receiptButtonTapped(_ sender: UIButton) {
        delegate?.setSelectedReceipt(index: receiptButtons.firstIndex(of: sender) ?? 0)
        self.dismiss(animated: true, completion: nil)
    }
}
