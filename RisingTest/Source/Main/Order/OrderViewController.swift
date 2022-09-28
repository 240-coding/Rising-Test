//
//  OrderViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

protocol SelectAddressDelegate {
    func setSelectedAddress(index: Int)
}

protocol SelectReceiptDelegate {
    func setSelectedReceipt(index: Int)
}

protocol SelectPaymentDelegate {
    func setSelectedPayment(paymentName: String)
}

protocol CheckAgreementDelegate {
    func setAgreementChecked(isChecked: Bool)
}

struct BasicOrderInfo {
    var goodsIndex: Int?
    var goodsName: String?
    var goodsImage: String?
    var goodsPrice: Int?
    var isSecurePayment, isDeilveryFee: String?
}

class OrderViewController: UIViewController {
    var addresses = [AddressesResult]()
    var selectedAddress: AddressesResult?
    var selectedReceiptIndex = 0
    var selectedPayment = "번개장터 간편결제"
    var selectedOtherPayment = "네이버페이"
    var isAgreementChecked = false
    
    var basicOrderInfo: BasicOrderInfo?
    let receiptOptions = ["문앞", "직접 받고 부재 시 문앞", "경비실", "우편함", "직접입력"]
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
        configureCollectionView()
        
        self.dismissKeyboardWhenTappedAround()
        
        AddressesDataManager().fetchAddressesData(delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchEditedAddress), name: Notification.Name.addressEdited, object: nil)
        
    }
    
    func setNavigationItem() {
        let item = UINavigationItem()
        item.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeViewController))
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        navigationBar.tintColor = .black
        
        navigationBar.items = [item]
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "AddressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddressCell")
        collectionView.register(UINib(nibName: "PointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PointCell")
        collectionView.register(UINib(nibName: "PriceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PriceCell")
        collectionView.register(UINib(nibName: "PaymentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PaymentCell")
        collectionView.register(UINib(nibName: "AgreementPayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AgreementPayCell")
    }
    
    // MARK: - Action
    @objc func closeViewController() {
        dismiss(animated: true)
    }
    
    @objc func editAddressButtonTapped() {
        guard let selectAddressViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SelectAddressViewController") as? SelectAddressViewController else {
            return
        }
        selectAddressViewController.addresses = self.addresses
        selectAddressViewController.delegate = self
        
        let nav = UINavigationController(rootViewController: selectAddressViewController)
        nav.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.preferredCornerRadius = 15
            }
        }
        nav.presentationController?.delegate = self
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func selectReceiptButtonTapped() {
        guard let selectReceiptViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SelectReceiptViewController") as? SelectReceiptViewController else {
            return
        }
        selectReceiptViewController.delegate = self
        selectReceiptViewController.selectedReceiptIndex = self.selectedReceiptIndex
        selectReceiptViewController.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = selectReceiptViewController.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 15
            }
        }
        self.present(selectReceiptViewController, animated: true, completion: nil)
    }
    
    @objc func fetchEditedAddress() {
        AddressesDataManager().fetchAddressesData(delegate: self)
        collectionView.reloadData()
    }
    
    @objc func otherPaymentChangeButtonTapped() {
        guard let paymentViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController else {
            return
        }
        paymentViewController.modalPresentationStyle = .fullScreen
        paymentViewController.delegate = self
        paymentViewController.selectedIndex = paymentViewController.paymentName.firstIndex(of: self.selectedOtherPayment) ?? 2
        
        self.present(paymentViewController, animated: false, completion: nil)
    }
    
    @objc func doneButtonTapped() {
        if isAgreementChecked {
            print("결제")
        } else {
            guard let agreementPopupViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "AgreementPopupViewController") as? AgreementPopupViewController else {
                return
            }
            agreementPopupViewController.modalPresentationStyle = .overFullScreen
            self.present(agreementPopupViewController, animated: false, completion: nil)
        }
    }
}

// MARK: - SelectDelegate
extension OrderViewController: SelectAddressDelegate, SelectReceiptDelegate, SelectPaymentDelegate, CheckAgreementDelegate {
    func setSelectedAddress(index: Int) {
        selectedAddress = addresses[index]
        collectionView.reloadData()
    }
    
    func setSelectedReceipt(index: Int) {
        selectedReceiptIndex = index
        collectionView.reloadData()
    }
    
    func setSelectedPayment(paymentName: String) {
        selectedPayment = paymentName
        if paymentName != "번개장터 간편결제" {
            selectedOtherPayment = paymentName
        }
        collectionView.reloadData()
    }
    
    func setAgreementChecked(isChecked: Bool) {
        isAgreementChecked = isChecked
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension OrderViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        fetchEditedAddress()
    }
}
// MARK: - Networking
extension OrderViewController: AddressDataDelegate {
    func didFetchAddressesData(result: [AddressesResult]) {
        addresses = result
        if let baseAddress = addresses.filter({ $0.isBaseAddress == "Y" }).first {
            selectedAddress = baseAddress
        }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView
extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as? OrderTitleCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let goodsImage = basicOrderInfo?.goodsImage {
                if let url = URL(string: goodsImage) {
                    cell.imageView.load(url: url)
                }
            }
            cell.priceLabel.text = String(basicOrderInfo?.goodsPrice ?? 0).insertComma + "원"
            cell.nameLabel.text = basicOrderInfo?.goodsName ?? ""
            
            return cell
        case 1: // 배송지
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCell", for: indexPath) as? AddressCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let selectedAddress = self.selectedAddress {
                cell.nameLabel.text = selectedAddress.userName
                cell.addressLabel.text = "\(selectedAddress.address)  \(selectedAddress.addressDetail)\n\(selectedAddress.userPhoneNum)"
            }
            
            cell.receiptLabel.text = receiptOptions[selectedReceiptIndex]
            
            
            cell.editAddressButton.addTarget(self, action: #selector(editAddressButtonTapped), for: .touchUpInside)
            let receiptGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectReceiptButtonTapped))
            cell.receiptView.addGestureRecognizer(receiptGestureRecognizer)
            
            return cell
        case 2: // 번개포인트
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PointCell", for: indexPath) as? PointCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 3: // 결제금액
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceCell", for: indexPath) as? PriceCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let goodsPrice = basicOrderInfo?.goodsPrice {
                cell.goodsPriceLabel.text = String(basicOrderInfo?.goodsPrice ?? 0).insertComma + "원"
                
                let tempSecurePaymentFee = String(Int(Double(goodsPrice) * 0.035))
                let securePaymentFee = tempSecurePaymentFee.substring(from: 0, to: tempSecurePaymentFee.count - 1) + "0"
                let totalPrice = String(goodsPrice + (Int(securePaymentFee) ?? 0))
                
                cell.securePaymentFeeLabel.text = "+\(securePaymentFee.insertComma)원"
                cell.deliveryFeeLabel.text = basicOrderInfo?.isDeilveryFee == "Y" ? "배송비포함" : "배송비별도"
                cell.totalPriceLabel.text = totalPrice.insertComma + "원"
            }
            
            return cell
        case 4: // 결제수단
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaymentCell", for: indexPath) as? PaymentCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if selectedPayment != "번개장터 간편결제" {
                cell.otherPaymentTypeLabel.text = selectedPayment
            }
            
            cell.delegate = self
            
            cell.otherPaymentChangeButton.addTarget(self, action: #selector(otherPaymentChangeButtonTapped), for: .touchUpInside)

            
            return cell
        case 5: // 동의 및 결제 버튼
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgreementPayCell", for: indexPath) as? AgreementPayCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            cell.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        switch indexPath.row {
        case 0:
            return CGSize(width: width, height: 200)
        case 1:
            return CGSize(width: width, height: 320)
        case 2:
            return CGSize(width: width, height: 200)
        case 3:
            return CGSize(width: width, height: 350)
        case 4:
            return CGSize(width: width, height: 750)
        case 5:
            return CGSize(width: width, height: 370)
        default:
            return CGSize()
        }
    }
    
    
}
