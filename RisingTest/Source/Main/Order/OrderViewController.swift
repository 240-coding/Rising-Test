//
//  OrderViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import UIKit

class OrderViewController: UIViewController {
    
    var goodsIndex: Int?
    var goodsName: String?
    var goodsImage: String?
    var goodsPrice: Int?
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "AddressCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddressCell")
        
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
    
    @objc func closeViewController() {
        dismiss(animated: true)
    }
}

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
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCell", for: indexPath) as? AddressCollectionViewCell else {
                return UICollectionViewCell()
            }
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
