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

class OrderViewController: UIViewController {
    
    var goodsIndex: Int?
    var goodsName: String?
    var goodsImage: String?
    var goodsPrice: Int?
    
    var addresses = [AddressesResult]()
    var selectedAddress: AddressesResult?
    var selectedReceiptIndex = 0
    
    let receiptOptions = ["문앞", "직접 받고 부재 시 문앞", "경비실", "우편함", "직접입력"]
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "AddressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddressCell")
        
        AddressesDataManager().fetchAddressesData(delegate: self)
        
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
    
    // MARK: - Action
    @objc func closeViewController() {
        dismiss(animated: true)
    }
    
    @objc func editAddressButtonTapped() {
        guard let selectAddressViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SelectAddressViewController") as? SelectAddressViewController else {
            print("엉?")
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
}

extension OrderViewController: SelectAddressDelegate, SelectReceiptDelegate {
    func setSelectedAddress(index: Int) {
        selectedAddress = addresses[index]
        collectionView.reloadData()
    }
    
    func setSelectedReceipt(index: Int) {
        selectedReceiptIndex = index
        collectionView.reloadData()
    }
}
// MARK: - Networking
extension OrderViewController {
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as? OrderTitleCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let goodsImage = goodsImage {
                if let url = URL(string: goodsImage) {
                    cell.imageView.load(url: url)
                }
            }
            cell.priceLabel.text = String(goodsPrice ?? 0).insertComma + "원"
            cell.nameLabel.text = goodsName ?? ""
            
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
            return CGSize(width: width, height: 500)
        default:
            return CGSize()
        }
    }
    
    
}
