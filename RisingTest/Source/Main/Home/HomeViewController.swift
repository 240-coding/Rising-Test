//
//  ViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    var currentBannerPage = 0
    var bannerImageData = [String]()
    let category = ["찜", "갤럭시", "최근본상품", "스타굿즈", "내피드", "카메라/DSLR", "내폰시세", "피규어/인형", "우리동네", "유아동/출산", "친구초대", "여성가방", "전체메뉴", "스니커즈"]
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageLabel: UILabel!
    @IBOutlet weak var homeCategoryCollectionView: UICollectionView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.tintColor = .black
        
        configureCollectionView()
        configureBannerPageLabel()
        HomeDataManager().fetchHomeData(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentBannerPage = 0
        if !bannerImageData.isEmpty {
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: currentBannerPage, section: 0) as IndexPath, at: .right, animated: true)
        }
    }
    
    func configureCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        homeCategoryCollectionView.delegate = self
        homeCategoryCollectionView.dataSource = self
    }
    
    func configureBannerPageLabel() {
        bannerPageLabel.layer.cornerRadius = 5
        bannerPageLabel.backgroundColor = UIColor(white: 0, alpha: 0.2)
    }
    
}

// MARK: - Networking
extension HomeViewController {
    func didFetchHomeData(result: HomeResult) {
        bannerImageData = result.getMainPageImgRes.map{ $0.mainPageImgUrl }
        setBannerPageLabelText(1)
        bannerCollectionView.reloadData()
//        bannerTimer()
    }
}

// MARK: - Banner
extension HomeViewController {
    func setBannerPageLabelText(_ currentPage: Int) {
        bannerPageLabel.text = "\(currentPage) / \(bannerImageData.count)"
    }
    
    // 2초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    
    func bannerMove() {
        if currentBannerPage == bannerImageData.count - 1 {
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            currentBannerPage = 0
            setBannerPageLabelText(currentBannerPage+1)
            return
        }
        currentBannerPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: currentBannerPage, section: 0) as IndexPath, at: .right, animated: true)
        setBannerPageLabelText(currentBannerPage+1)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView && scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            setBannerPageLabelText(Int(round(value))+1)
            currentBannerPage = Int(round(value))
        }
    }
}

// MARK: - UICollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? bannerImageData.count : 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            guard let url = URL(string: "https://pbs.twimg.com/media/Errj1nvUYAAJVrl?format=jpg&name=large") else {
                print("Fail to load banner image")
                return cell
            }
            cell.bannerImageView.load(url: url)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCell", for: indexPath) as? HomeCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = UIImage(named: "homecategory\(indexPath.row+1)")
            cell.categoryNameLabel.text = category[indexPath.row]
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == bannerCollectionView ? CGSize(width: view.frame.width, height: 350) : CGSize(width: (collectionView.frame.width-32) / 5, height: (collectionView.frame.height-16) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == bannerCollectionView ? 0 : 8
    }
    
    
}
