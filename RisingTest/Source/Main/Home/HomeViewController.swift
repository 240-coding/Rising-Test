//
//  ViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/18.
//

import UIKit

extension Notification.Name {
    static let recommend = Notification.Name("Recommend")
    static let recommendCellTapped = Notification.Name("RecommendCellTapped")
//    static let postData = Notification.Name("PostData")
}

class HomeViewController: UIViewController {
    
    var currentBannerPage = 0
    var bannerImageData = [String]()
    let category = ["찜", "갤럭시", "최근본상품", "스타굿즈", "내피드", "카메라/DSLR", "내폰시세", "피규어/인형", "우리동네", "유아동/출산", "친구초대", "여성가방", "전체메뉴", "스니커즈"]
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet var contentScrollViewHeight: NSLayoutConstraint!
    @IBOutlet var containerViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageLabel: UILabel!
    @IBOutlet weak var homeCategoryCollectionView: UICollectionView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.tintColor = .black
        
        configureCollectionView()
        configureBannerPageLabel()
        configureNavigationBar()
        HomeDataManager().fetchHomeData(delegate: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeContentScrollViewHeight(notification:)), name: Notification.Name.recommend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recommendCellTapped(notification:)), name: Notification.Name.recommendCellTapped, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentBannerPage = 0
        if !bannerImageData.isEmpty {
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: currentBannerPage, section: 0) as IndexPath, at: .right, animated: true)
        }
    }
    
    // MARK: - Configure UI
    func configureNavigationBar() {
        let menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(menuBarButtonTapped))
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBarButtonTapped))
        let notificationBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: #selector(noficiationBarButtonTapped))
        
        navigationItem.leftBarButtonItem = menuBarButtonItem
        navigationItem.rightBarButtonItems = [notificationBarButtonItem, searchBarButtonItem]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func menuBarButtonTapped() {
        print("Menu Button Tapped")
    }
    
    @objc func searchBarButtonTapped() {
        let searchViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchNavigationController")
//        navigationController?.pushViewController(searchViewController, animated: true)
        searchViewController.modalPresentationStyle = .fullScreen
        present(searchViewController, animated: true)
    }
    
    @objc func noficiationBarButtonTapped() {
        print("Noti Button Tapped")
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
        if let childViewController = children.last as? TabManViewController {
            childViewController.homeData = result.getHomeDataRes
            childViewController.viewWillAppear(true)
        }
    }
}

// MARK: - Notification
extension HomeViewController {
    @objc func changeContentScrollViewHeight(notification: Notification) {
        containerViewHeight.constant = notification.userInfo?["height"] as! CGFloat
        contentScrollViewHeight.constant = view.frame.height
        self.viewWillAppear(true)
    }
    
    @objc func recommendCellTapped(notification: Notification) {
        guard let detailViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        self.navigationController?.pushViewController(detailViewController, animated: true)
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
        } else {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            
            if scrollView.contentOffset.y <= 0 {
                navigationController?.navigationBar.tintColor = .white
                appearance.backgroundColor = .clear
            } else {
                navigationController?.navigationBar.tintColor = .black
                appearance.backgroundColor = .white
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
            guard let url = URL(string: bannerImageData[indexPath.row]) else {
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
