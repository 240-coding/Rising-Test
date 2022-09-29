//
//  RecommendCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/24.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var payImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeStackView: UIStackView!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        payImageView.isHidden = true
        
        imageView.layer.cornerRadius = 5
        heartButton.layer.shadowOpacity = 0.5
        heartButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        heartButton.layer.shadowRadius = 1
        
        setHeartButtonState()
    }
    
    func setHeartButtonState() {
        if heartButton.isSelected {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = UIColor(named: "red")
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .white
        }
    }
}
