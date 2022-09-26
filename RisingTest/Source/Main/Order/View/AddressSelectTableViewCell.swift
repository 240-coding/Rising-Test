//
//  AddressSelectTableViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class AddressSelectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var baseAddressLabel: PaddingLabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet var addressLabelTrailing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        baseAddressLabel.layer.borderColor = UIColor(named: "red")?.cgColor
        baseAddressLabel.layer.borderWidth = 1
        baseAddressLabel.layer.cornerRadius = baseAddressLabel.frame.height / 2
    }
    
    func setAddressLabelTrailing() {
        addressLabelTrailing.constant = baseAddressLabel.isHidden ? 8 : 55 + 4 + 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
