//
//  UserGoodsFooterCollectionReusableView.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class UserGoodsFooterCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var moreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        moreButton.layer.cornerRadius = 5
    }
    
}
