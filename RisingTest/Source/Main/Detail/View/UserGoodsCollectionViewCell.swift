//
//  UserGoodsCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class UserGoodsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var payImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        payImageView.isHidden = true
        
        imageView.layer.cornerRadius = 5
        likeButton.layer.shadowOpacity = 0.5
        likeButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        likeButton.layer.shadowRadius = 1
        likeButton.layer.shadowColor = UIColor.gray.cgColor
        
    }
}
