//
//  OptionViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/30.
//

import UIKit

class OptionViewController: UIViewController {
    
    var delegate: OptionDelegate?
    
    @IBOutlet var amountView: UIView!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var goodsStatusButton: [UIButton]!
    @IBOutlet var exchangeButton: [UIButton]!
    
    @IBOutlet var completeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboardWhenTappedAround()
        
        amountView.layer.cornerRadius = 5
        amountView.clipsToBounds = true
        amountView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
        amountView.layer.borderWidth = 1
        
        goodsStatusButton[0].isSelected = true
        exchangeButton[0].isSelected = true
        
        goodsStatusButton.forEach { button in
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            button.layer.borderColor = UIColor(named: "lightgray")?.cgColor
            setButtonStyle(button)
            button.addTarget(self, action: #selector(goodsStatusButtonTapped(sender:)), for: .touchUpInside)
        }
        
        exchangeButton.forEach { button in
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
            button.layer.borderColor = UIColor(named: "lightgray")?.cgColor
            setButtonStyle(button)
            button.addTarget(self, action: #selector(exchangeButtonTapped(sender:)), for: .touchUpInside)
        }
        
        completeButton.layer.cornerRadius = 5
    }
    
    func setButtonStyle(_ button: UIButton) {
        button.backgroundColor = button.isSelected ? UIColor(named: "lightred") : .white
        button.titleLabel?.font = button.isSelected ? .boldSystemFont(ofSize: 14) : .systemFont(ofSize: 14)
        button.setTitleColor(UIColor(named: button.isSelected ?  "red" : "gray"), for: .normal)
        button.layer.borderWidth = button.isSelected ? 0 : 1
    }
    
    // MARK: - Action
    @objc func goodsStatusButtonTapped(sender: UIButton) {
        if !sender.isSelected {
            if sender == goodsStatusButton[0] {
                goodsStatusButton[0].isSelected = true
                goodsStatusButton[1].isSelected = false
            } else {
                goodsStatusButton[0].isSelected = false
                goodsStatusButton[1].isSelected = true
            }
            goodsStatusButton.forEach { button in
                setButtonStyle(button)
            }
        }
    }
    
    @objc func exchangeButtonTapped(sender: UIButton) {
        if !sender.isSelected {
            if sender == exchangeButton[0] {
                exchangeButton[0].isSelected = true
                exchangeButton[1].isSelected = false
            } else {
                exchangeButton[0].isSelected = false
                exchangeButton[1].isSelected = true
            }
            exchangeButton.forEach { button in
                setButtonStyle(button)
            }
        }
    }
    
    @IBAction func completeButtonTapped() {
        dismiss(animated: true) {
            guard let amountText = self.amountTextField.text, let amount = Int(amountText) else {
                return
            }
            let condition = self.goodsStatusButton[0].isSelected ? "0" : "1"
            let isExchange = self.exchangeButton[0].isSelected ? "N" : "Y"
            self.delegate?.loadSelectedOptions(amount: amount, condition: condition, isExchange: isExchange)
        }
    }

}
