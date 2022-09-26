//
//  AddressManagementTableViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class AddressManagementTableViewCell: UITableViewCell {

    @IBOutlet weak var baseAddressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
