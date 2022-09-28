//
//  AgreementPayCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class AgreementPayCollectionViewCell: UICollectionViewCell {
    
    var isChecked = false
    var delegate: CheckAgreementDelegate?
    
    @IBOutlet var agreementStackView: UIStackView!
    @IBOutlet var checkImageView: UIImageView!
    @IBOutlet var doneButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        doneButton.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(agreementStackViewTapped))
        agreementStackView.addGestureRecognizer(tap)
    }
    
    @objc func agreementStackViewTapped() {
        isChecked.toggle()
        checkImageView.tintColor = isChecked ? UIColor(named: "red") : UIColor(named: "lightgray")
        delegate?.setAgreementChecked(isChecked: isChecked)
    }

}
