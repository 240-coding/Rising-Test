//
//  WritePhotoCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/21.
//

import UIKit

class WritePhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        closeButton.setRoundCorner()
        closeButton.layer.borderColor = UIColor(named: "lightgray")?.cgColor
        closeButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = 3
        imageView.layer.cornerRadius = 5
        
        closeButton.setTitle("", for: .normal)
        editButton.setTitle("", for: .normal)
    }

}
