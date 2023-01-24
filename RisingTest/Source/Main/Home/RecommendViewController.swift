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
    var likeData = [Int: Int]() // goodsIdx: goodsLikeIdx

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LikeDataManager().fetchLikeList(delegate: self)
        if homeData.isEmpty {
            collectionView.reloadData()
        }
        self.viewDidLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newHeight = collectionView.contentSize.height + 100
        if collectionViewHeight.constant != newHeight {
            collectionViewHeight.constant = newHeight
            NotificationCenter.default.post(name: Notification.Name.recommend, object: nil, userInfo: ["height": collectionViewHeight.constant])
        }
    }
    
    // MARK: - Action
    @objc func heartButtonTapped(_ sender: UIButton) {
        print(sender.tag)
        sender.isSelected.toggle()
        if sender.isSelected {
            LikeDataManager().postLike(goodsIdx: sender.tag, delegate: self)
            
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            sender.tintColor = UIColor(named: "red")
        } else {
            guard let goodsLikeIdx = likeData[sender.tag] else { return }
            likeData[sender.tag] = nil
            LikeDataManager().patchLike(goodsLikeIdx: goodsLikeIdx, delegate: self)
            
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            sender.tintColor = .white
        }
    }
}
// MARK: - Networking
extension RecommendViewController: LikeDelegate {
    func didFetchLikeListData(result: [LikeListResult]) {
        likeData = [:]
        for like in result {
            likeData[like.goodsIdx] = like.goodsLikeIdx
        }
        print(likeData)
        collectionView.reloadData()
    }
    
    func didPostLike(goodsIdx: Int, result: PostLikeResult) {
        likeData[goodsIdx] = result.goodsLikeIdx
        print(result.goodsLikeIdx)
    }
    
    func didPatchLike(result: String) {
        print(result)
    }
}

// MARK: - UICollectionView
extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = homeData[indexPath.row]
        if let urlString = data.gimgs.first?.goodsImgUrl, let url = URL(string: urlString) {
            cell.imageView.load(url: url)
        }
        cell.priceLabel.text = String(data.goodsPrice).insertComma + "원"
        cell.titleLabel.text = data.goodsName
        cell.heartButton.isSelected = likeData[data.goodsIdx] == nil ? false : true
        cell.setHeartButtonState()
        cell.heartButton.tag = data.goodsIdx
        cell.heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        cell.locationLabel.text = data.address?.substring(from: 0, to: 10) ?? "지역 정보 없음"
        cell.timeLabel.text = data.goodsUpdatedAtTime
        cell.payImageView.isHidden = data.isSecurePayment == "Y" ? false : true
        cell.likeStackView.isHidden = data.goodsLike == 0 ? false: true
        cell.likeLabel.text = String(data.likes)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 32) / 2, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        NotificationCenter.default.post(name: Notification.Name.recommendCellTapped, object: nil, userInfo: ["goodsId": homeData[indexPath.row].goodsIdx])
        guard let detailViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailViewController.goodsIndex = homeData[indexPath.row].goodsIdx
        if let goodsLikeIdx = likeData[homeData[indexPath.row].goodsIdx] {
            detailViewController.isLiked = true
            detailViewController.goodsLikeIndex = goodsLikeIdx
        } else {
            detailViewController.isLiked = false
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
