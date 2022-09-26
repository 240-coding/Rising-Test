//
//  AddressManagementTableViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class AddressManagementTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var baseAddressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 5
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
