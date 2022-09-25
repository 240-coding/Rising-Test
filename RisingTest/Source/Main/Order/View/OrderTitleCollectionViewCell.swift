//
//  OrderTitleCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class OrderTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
    }
}
