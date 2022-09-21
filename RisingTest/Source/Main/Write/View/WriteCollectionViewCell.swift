//
//  WriteCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/21.
//

import UIKit

class WriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var optionView: [UIView]!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var priceWonImageView: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var deliveryFeeButton: UIButton!
    
    @IBOutlet weak var optionSelectButton: UIButton!
    @IBOutlet weak var optionLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        optionView.forEach { view in
            view.addBorders(edges: .bottom, color: UIColor(named: "lightgray") ?? .systemGray3, width: 1.0)
        }
        
        nameTextField.delegate = self
        priceTextField.delegate = self
        
        nameTextField.tag = 0
        tagButton.tag = 2
        priceTextField.tag = 3
        
        optionSelectButton.layer.cornerRadius = 3
        optionSelectButton.layer.borderWidth = 1
        optionSelectButton.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }
    
    // MARK: - Action
    @IBAction func pressedTagButton(_ sender: UIButton) {
        optionView[sender.tag].addBorders(edges: .bottom, color: .black, width: 1.0)
    }
    
    @IBAction func pressedDeliveryFeeButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            sender.tintColor = UIColor(named: "red") ?? UIColor()
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            sender.tintColor = UIColor(named: "lightgray") ?? .systemGray3
        }
    }
}

// MARK: - UITextFieldDelegate
extension WriteCollectionViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        optionView[textField.tag].addBorders(edges: .bottom, color: .black, width: 1.0)
        
        if textField.tag == 3 {
            priceWonImageView.tintColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        optionView[textField.tag].addBorders(edges: .bottom, color: UIColor(named: "lightgray") ?? .systemGray3, width: 1.0)
        
        if textField.tag == 3 {
            priceWonImageView.tintColor = UIColor(named: "lightgray") ?? .systemGray3
        }
    }
}
