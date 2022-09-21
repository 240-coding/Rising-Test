//
//  WritePhotoCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/20.
//

import UIKit

class WriteUploadCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var grayView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        grayView.layer.cornerRadius = 5
    }

}
