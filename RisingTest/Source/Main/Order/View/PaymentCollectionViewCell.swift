//
//  PaymentCollectionViewCell.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/28.
//

import UIKit

class PaymentCollectionViewCell: UICollectionViewCell {
    
    var isPaymentSelected = false
    var selectedPaymentIndex = 0
    
    var delegate: SelectPaymentDelegate?
    
    // 번개장터 간편결제
    @IBOutlet var bunjangPaymentStackView: UIStackView!
    @IBOutlet var bunjangPaymentCircleImageView: UIImageView!
    @IBOutlet var bunjangPaymentLabel: UILabel!
    
    @IBOutlet var bunjangPaymentSelectStackView: UIStackView!
    @IBOutlet var bunjangPaymentSelectCheckImageView: UIImageView!
    @IBOutlet var bunjangPaymentSelectLabel: UILabel!
    
    @IBOutlet var greenView: UIView!
    @IBOutlet var greenButton: UIButton!
    
    
    // 다른 결제수단
    @IBOutlet var otherPaymentStackView: UIStackView!
    @IBOutlet var otherPaymentCircleImageView: UIImageView!
    @IBOutlet var otherPaymentLabel: UILabel!
    
    @IBOutlet var otherPaymentSelectStackView: UIStackView!
    @IBOutlet var otherPaymentSelectCheckImageView: UIImageView!
    @IBOutlet var otherPaymentSelectLabel: UILabel!
    
    @IBOutlet var otherPaymentView: UIView!
    @IBOutlet var otherPaymentTypeLabel: UILabel!
    @IBOutlet var otherPaymentChangeButton: UIButton!
    
    @IBOutlet var todayBenefitView: UIView!
    @IBOutlet var paycoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bunjangPaymentStackView.tag = 0
        otherPaymentStackView.tag = 1
        
        let bunjangPaymentSelectTapGeseture = UITapGestureRecognizer(target: self, action: #selector(selectPayment))
        let otherPaymentSelectTapGeseture = UITapGestureRecognizer(target: self, action: #selector(selectPayment))
        bunjangPaymentSelectStackView.addGestureRecognizer(bunjangPaymentSelectTapGeseture)
        otherPaymentSelectStackView.addGestureRecognizer(otherPaymentSelectTapGeseture)
        
        let bunjangPaymentRadioTap = UITapGestureRecognizer(target: self, action: #selector(paymentStackViewTapped))
        let otherPaymentRadioTap = UITapGestureRecognizer(target: self, action: #selector(paymentStackViewTapped))
        
        bunjangPaymentStackView.addGestureRecognizer(bunjangPaymentRadioTap)
        otherPaymentStackView.addGestureRecognizer(otherPaymentRadioTap)
        
        greenView.layer.cornerRadius = 5
        greenButton.layer.cornerRadius = 5
        otherPaymentView.layer.cornerRadius = 5
        otherPaymentView.clipsToBounds = true
        otherPaymentView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
        otherPaymentView.layer.borderWidth = 1
        
        todayBenefitView.layer.cornerRadius = 5
        todayBenefitView.clipsToBounds = true
        paycoImageView.layer.cornerRadius = paycoImageView.frame.height / 2
        
        setPaymentStatus()
    }
    
    @objc func selectPayment() {
        isPaymentSelected.toggle()
        if isPaymentSelected {
            bunjangPaymentSelectCheckImageView.tintColor = UIColor(named: "red")
            otherPaymentSelectCheckImageView.tintColor = UIColor(named: "red")
            bunjangPaymentSelectLabel.textColor = .black
            otherPaymentSelectLabel.textColor = .black
        } else {
            bunjangPaymentSelectCheckImageView.tintColor = UIColor(named: "lightgray")
            otherPaymentSelectCheckImageView.tintColor = UIColor(named: "lightgray")
            bunjangPaymentSelectLabel.textColor = UIColor(named: "gray")
            otherPaymentSelectLabel.textColor = UIColor(named: "gray")
        }
    }
    
    @objc func paymentStackViewTapped(recognizer: UITapGestureRecognizer) {
        if recognizer.view == bunjangPaymentStackView {
            selectedPaymentIndex = 0
            delegate?.setSelectedPayment(paymentName: "번개장터 간편결제")
        } else {
            selectedPaymentIndex = 1
            delegate?.setSelectedPayment(paymentName: otherPaymentTypeLabel.text!)
        }
        setPaymentStatus()
        
    }
    
    func setPaymentStatus() {
        if selectedPaymentIndex == 0 {
            bunjangPaymentCircleImageView.image = UIImage(systemName: "record.circle")
            bunjangPaymentCircleImageView.tintColor = UIColor(named: "red")
            bunjangPaymentLabel.textColor = .black
            bunjangPaymentSelectStackView.isHidden = false
            
            otherPaymentCircleImageView.image = UIImage(systemName: "circle")
            otherPaymentCircleImageView.tintColor = UIColor(named: "lightgray")
            otherPaymentLabel.textColor = UIColor(named: "gray")
            otherPaymentSelectStackView.isHidden = true
            
        } else {
            otherPaymentCircleImageView.image = UIImage(systemName: "record.circle")
            otherPaymentCircleImageView.tintColor = UIColor(named: "red")
            otherPaymentLabel.textColor = .black
            otherPaymentSelectStackView.isHidden = false
            
            bunjangPaymentCircleImageView.image = UIImage(systemName: "circle")
            bunjangPaymentCircleImageView.tintColor = UIColor(named: "lightgray")
            bunjangPaymentLabel.textColor = UIColor(named: "gray")
            bunjangPaymentSelectStackView.isHidden = true
        }
    }
    
}
