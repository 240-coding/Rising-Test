//
//  SearchPopularCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/23.
//

import UIKit

class SearchPopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        notificationButton.layer.cornerRadius = notificationButton.frame.height / 2
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "lightgray")?.cgColor ?? UIColor.black.cgColor
        self.layer.cornerRadius = 3
    }
}
