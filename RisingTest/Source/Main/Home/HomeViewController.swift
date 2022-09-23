//
//  ViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    var currentBannerPage = 0
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.tintColor = .black
        
        configureCollectionView()
        configureBannerPageLabel()
        bannerTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentBannerPage = 0
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: currentBannerPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    func configureCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
    }
    
    func configureBannerPageLabel() {
        bannerPageLabel.layer.cornerRadius = 5
        bannerPageLabel.backgroundColor = UIColor(white: 0, alpha: 0.2)
    }
    
    // 2초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if currentBannerPage == 4 {
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            currentBannerPage = 0
            bannerPageLabel.text = "\(currentBannerPage+1) / 5"
            return
        }
        // 다음 페이지로 전환
        currentBannerPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: currentBannerPage, section: 0) as IndexPath, at: .right, animated: true)
        bannerPageLabel.text = "\(currentBannerPage+1) / 5"
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView && scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            bannerPageLabel.text = "\(Int(round(value))+1) / 5"
            currentBannerPage = Int(round(value))
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.bannerImageView.image = UIImage(named: "login3")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
