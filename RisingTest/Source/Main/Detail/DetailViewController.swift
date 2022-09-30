//
//  DetailViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var goodsIndex: Int?
    var goodsLikeIndex: Int?
    var goodsImages = [String]()
    var isLiked: Bool?
    var goodsData: GetGoodsDataRes?
    var userGoods = [GetStoreGoodsRe]()
    var userReviews = [GetStoreReviewRe]()
    
    @IBOutlet weak var bottomButtonView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet var labelHeight: NSLayoutConstraint!
    
    // 상품 정보
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var payImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var reportButton: UIButton!
    
    // 상점 정보
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userRateLabel: UILabel!
    @IBOutlet var userFollowerLabel: UILabel!
    @IBOutlet var userFollowButton: UIButton!

    @IBOutlet weak var userGoodsCollectionView: UICollectionView!
    @IBOutlet var userGoodsCollectionViewHeight: NSLayoutConstraint!
    
    // 상점 거래후기
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet var reviewCollectionViewHeight: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureBottomButtonView()
        configureButtons()
        configureHeartButton()
        configurePageLabel()

        navigationController?.navigationBar.tintColor = .black
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        userGoodsCollectionView.delegate = self
        userGoodsCollectionView.dataSource = self
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
        
        userGoodsCollectionView.register(UINib(nibName: "UserGoodsCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UserGoodsHeader")
        if let goodsIndex = goodsIndex {
            GoodsDataManager().fetchGoodsData(goodsIndex: String(goodsIndex), delegate: self)
        }
        
        talkButton.addTarget(self, action: #selector(talkButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userGoodsCollectionViewHeight.constant = userGoodsCollectionView.contentSize.height
        reviewCollectionViewHeight.constant = reviewCollectionView.contentSize.height
        
        
        var height = scrollView.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? scrollView.contentSize.height
        
        if userGoodsCollectionView.isHidden {
            height -= userGoodsCollectionViewHeight.constant + 250
        }
        if reviewCollectionView.isHidden {
            height -= reviewCollectionViewHeight.constant + 250
        }
        
        scrollView.contentSize.height = height * 1.4
        view.layoutIfNeeded()
    }
    
    // MARK: - Configure UI
    func configureNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popViewController))
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchBarButtonTapped))
        let shareBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(shareBarButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItems = [shareBarButtonItem, searchBarButtonItem]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func searchBarButtonTapped() {
        let searchViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchNavigationController")
//        navigationController?.pushViewController(searchViewController, animated: true)
        searchViewController.modalPresentationStyle = .fullScreen
        present(searchViewController, animated: true)
    }
    
    @objc func shareBarButtonTapped() {
        print("Share Button Tapped")
    }
    
    func configureBottomButtonView() {
        bottomButtonView.layer.borderWidth = 1
        bottomButtonView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }
    
    func configureButtons() {
        talkButton.layer.cornerRadius = 5
        buyButton.layer.cornerRadius = 5
        
        reportButton.layer.borderWidth = 1
        reportButton.layer.borderColor = UIColor(named: "lightgray")?.cgColor
        reportButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: view.frame.width - 100, bottom: 0, right: 0)
        userFollowButton.layer.cornerRadius = 5
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func configureHeartButton() {
        guard let isLiked = isLiked else {
            return
        }

        if isLiked {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = UIColor(named: "red")
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = UIColor(named: "gray")
        }
    }
    
    func configurePageLabel() {
        pageLabel.backgroundColor = UIColor(white: 0, alpha: 0.2)
        pageLabel.layer.cornerRadius = 5
    }
    
    func setImagePageLabelText(_ currentPage: Int) {
        pageLabel.text = "\(currentPage) / \(goodsImages.count)"
    }
    
    // MARK: - Action
    @IBAction func heartButtonTapped(_ sender: Any) {
        isLiked?.toggle()
        
        guard let isLiked = isLiked else {
            return
        }
        
        if isLiked {
            if let goodsIndex = goodsIndex {
                LikeDataManager().postLike(goodsIdx: goodsIndex, delegate: self)
            }
        } else {
            if let goodsLikeIndex = goodsLikeIndex {
                LikeDataManager().patchLike(goodsLikeIdx: goodsLikeIndex, delegate: self)
            }
        }
    }
    
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        guard let orderViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "OrderViewController") as? OrderViewController else {
            return
        }
        orderViewController.modalPresentationStyle = .fullScreen
        orderViewController.basicOrderInfo = BasicOrderInfo(goodsIndex: goodsData?.goodsIdx, goodsName: goodsData?.goodsName, goodsImage: goodsData?.imgs.first?.goodsImgUrl, goodsPrice: goodsData?.goodsPrice, isSecurePayment: goodsData?.isSecurePayment, isDeilveryFee: goodsData?.isDeilveryFee)
        
        present(orderViewController, animated: true, completion: nil)
    }
    
    @objc func talkButtonTapped() {
        guard let orderDetailViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailViewController") as? OrderDetailViewController else {
            return
        }
        orderDetailViewController.modalPresentationStyle = .fullScreen
        present(orderDetailViewController, animated: true, completion: nil)
    }
}

// MARK: - Networking
extension DetailViewController {
    func didFetchGoodsData(result: GoodsResult) {
        // 상품 정보
        goodsData = result.getGoodsDataRes
        guard let goodsData = goodsData else { return }
        priceLabel.text = String(goodsData.goodsPrice).insertComma + "원"
        titleLabel.text = goodsData.goodsName
        locationLabel.text = goodsData.goodsAddress ?? "지역 정보 없음"
        timeLabel.text = goodsData.goodsUpdatedAtTime
        descriptionLabel.text = goodsData.goodsContent
        likeLabel.text = String(goodsData.likes[0].likes)
        
        conditionLabel.text = goodsData.goodsCondition == "0" ? "중고상품" : "새상품"
        amountLabel.text = "총 \(goodsData.goodsCount)개"
        deliveryFeeLabel.text = goodsData.isDeilveryFee == "Y" ? "배송비포함" : "배송비별도"
        exchangeLabel.text = goodsData.isExchange == "Y" ? "교환가능" : "교환불가"
        
        payImageView.isHidden = goodsData.isSecurePayment == "Y" ? false : true
        
        goodsImages = goodsData.imgs.map{ $0.goodsImgUrl }
        
        setImagePageLabelText(1)
        imageCollectionView.reloadData()
        
        // 상점 정보
        let userData = result.getStoreDataRes
        if let urlString = userData.userImgUrl {
            if let url = URL(string: urlString) {
                profileImageView.load(url: url)
            }
        } else {
            profileImageView.image = UIImage(named: "defaultprofile") ?? UIImage()
        }
        
        userNameLabel.text = userData.userNickName
        userRateLabel.text = String(userData.score)
        userFollowerLabel.text = "팔로워 \(userData.follow.first?.follow ?? 0)"
        
        // 상점 상품
        userGoods = result.getStoreGoodsRes
        if userGoods.isEmpty {
            userGoodsCollectionView.isHidden = true
        } else {
            userGoodsCollectionView.reloadData()
        }
        
        // 상점 거래후기
        userReviews = result.getStoreReviewRes
        if userReviews.isEmpty {
            reviewCollectionView.isHidden = true
        } else {
            reviewCollectionView.reloadData()
        }
        
        self.viewDidLayoutSubviews()
    }
}
// Like
extension DetailViewController: LikeDelegate {
    func didFetchLikeListData(result: [LikeListResult]) {
        
    }
    
    func didPostLike(goodsIdx: Int, result: PostLikeResult) {
        print(result.goodsLikeIdx)
        isLiked = true
        configureHeartButton()
    }
    
    func didPatchLike(result: String) {
        print(result)
        isLiked = false
        configureHeartButton()
    }
    
    
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == imageCollectionView && scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            setImagePageLabelText(Int(round(value))+1)
        }
    }
}

// MARK: - UICollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            return goodsImages.count
        } else if collectionView == userGoodsCollectionView {
            return userGoods.count
        } else {
            return userReviews.count > 3 ? 2 : userReviews.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsImageCell", for: indexPath) as? ImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if let url = URL(string: goodsImages[indexPath.row]) {
                cell.imageView.load(url: url)
            }
            
            return cell
        } else if collectionView == userGoodsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserGoodsCell", for: indexPath) as? UserGoodsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let data = userGoods[indexPath.row]
            
            if let url = URL(string: data.getGoodsImgRes[0].goodsImgUrl) {
                cell.imageView.load(url: url)
            }
//            cell.payImageView.isHidden = data
            cell.priceLabel.text = String(data.goodsPrice).insertComma + "원"
            cell.titleLabel.text = data.goodsName
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as? ReviewCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let data = userReviews[indexPath.row]
            cell.ratingLabel.text = String(data.score)
            cell.contentLabel.text = data.reviewContent
            cell.usernameLabel.text = String(data.reviewIdx)
            cell.timeLabel.text = data.reviewUpdatedAtTime
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        detailViewController.goodsIndex = userGoods[indexPath.row].goodsIdx
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if collectionView == imageCollectionView {
            return CGSize(width: width, height: 400.0)
        } else if collectionView == userGoodsCollectionView {
            return CGSize(width: (width - 56) / 3, height: 225)
        } else {
            let label: UILabel = {
                let label = UILabel()
                label.text = userReviews[indexPath.row].reviewContent
                label.font = .systemFont(ofSize: 14)
                label.sizeToFit()
                
                return label
            }()
            return CGSize(width: width, height: label.frame.height + 70)
        }
    }
    
    // Reusable View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == userGoodsCollectionView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UserGoodsHeader", for: indexPath) as? UserGoodsCollectionReusableView else {
                    return UICollectionReusableView()
                }
                header.goodsLabel.text = "이 상점의 상품 \(userGoods.count)"
                
                return header
            case UICollectionView.elementKindSectionFooter:
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UserGoodsFooter", for: indexPath) as? UserGoodsFooterCollectionReusableView else {
                    return UICollectionReusableView()
                }
                return footer
            default:
                assert(false)
            }
        } else if collectionView == userGoodsCollectionView {
            return UICollectionReusableView()
        } else {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReviewHeader", for: indexPath) as? ReviewHeaderCollectionReusableView else {
                    return UICollectionReusableView()
                }
                header.titleLabel.text = "이 상점의 거래후기 \(userReviews.count)"
                
                return header
            case UICollectionView.elementKindSectionFooter:
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ReviewFooter", for: indexPath) as? ReviewFooterCollectionReusableView else {
                    return UICollectionReusableView()
                }
                
                return footer
            default:
                assert(false)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize()
        } else {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize()
        } else {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
    }
}
