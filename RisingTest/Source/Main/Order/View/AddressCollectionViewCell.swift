//
//  AddressCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var addressView: UIView!
    @IBOutlet var baseAddressLabel: PaddingLabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var receiptView: UIView!
    @IBOutlet var receiptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addressView.layer.cornerRadius = 5
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
        
        receiptView.layer.cornerRadius = 5
        receiptView.layer.borderWidth = 1
        receiptView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }
    
    @IBAction func changeAddressButtonTap(_ sender: Any) {
        print("주소 변경")
    }
    

}
