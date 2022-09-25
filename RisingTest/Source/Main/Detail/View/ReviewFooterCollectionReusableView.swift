//
//  ReviewFooterCollectionReusableView.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class ReviewFooterCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreButton.layer.cornerRadius = 5
    }
}
