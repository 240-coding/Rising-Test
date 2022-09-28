//
//  PriceCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/28.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {

    @IBOutlet var priceView: UIView!
    @IBOutlet var goodsPriceLabel: UILabel!
    @IBOutlet var securePaymentFeeLabel: UILabel!
    @IBOutlet var deliveryFeeLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceView.layer.cornerRadius = 5
        priceView.clipsToBounds = true
        priceView.layer.borderWidth = 1
        priceView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }

}
