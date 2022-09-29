//
//  OrderDetailHeaderView.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class OrderDetailHeaderView: UIView {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var payCompleteLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        payCompleteLabel.layer.borderWidth = 1
        payCompleteLabel.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        loadView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        loadView()
//    }
//    
//    private func loadView() {
//        let view = Bundle.main.loadNibNamed("OrderDetailHeaderView", owner: self, options: nil)?.first as! UIView
//        view.frame = bounds
//        addSubview(view)
//    }

}
