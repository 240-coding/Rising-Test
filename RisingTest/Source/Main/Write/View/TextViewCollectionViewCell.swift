//
//  TextViewCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/22.
//

import UIKit

protocol TextViewCollectionViewCellDelegate: Any {
    func updateCollectionViewCellHeight(_ textView: UITextView)
}

class TextViewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textView: UITextView!
    
    var delegate: TextViewCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
    }
}

extension TextViewCollectionViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = delegate {
            delegate.updateCollectionViewCellHeight(textView)
        }
    }
}
