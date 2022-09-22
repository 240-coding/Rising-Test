//
//  SearchRecentCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/23.
//

import UIKit

class SearchRecentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "lightgray")?.cgColor ?? UIColor.black.cgColor
        self.layer.cornerRadius = 3
    }
}
