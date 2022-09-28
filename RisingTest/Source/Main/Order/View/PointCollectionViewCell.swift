//
//  PointCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/28.
//

import UIKit

class PointCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var textFieldView: UIView!
    @IBOutlet var allButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textFieldView.layer.cornerRadius = 5
        textFieldView.clipsToBounds = true
        textFieldView.layer.borderWidth = 1
        textFieldView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
        
        allButton.layer.cornerRadius = 5
    }

}
