//
//  RecommendViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/24.
//

import UIKit

class RecommendViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    
    var homeData = [HomeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        self.viewDidLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = collectionView.contentSize.height + 100
        print(collectionViewHeight.constant)
        NotificationCenter.default.post(name: Notification.Name.recommend, object: nil, userInfo: ["height": collectionViewHeight.constant])
    }
}
extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = homeData[indexPath.row]
        if let url = URL(string: data.gimgs[0].goodsImgUrl) {
            cell.imageView.load(url: url)
        }
        cell.priceLabel.text = String(data.goodsPrice).insertComma + "원"
        cell.titleLabel.text = data.goodsName
        cell.locationLabel.text = data.address.substring(from: 0, to: 10)
        cell.timeLabel.text = data.goodsUpdatedAtTime
        cell.payImageView.isHidden = data.isSecurePayment == "Y" ? false : true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 32) / 2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        NotificationCenter.default.post(name: Notification.Name.recommendCellTapped, object: nil, userInfo: ["goodsId": homeData[indexPath.row].goodsIdx])
        guard let detailViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailViewController.goodsIndex = homeData[indexPath.row].goodsIdx
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    
}
