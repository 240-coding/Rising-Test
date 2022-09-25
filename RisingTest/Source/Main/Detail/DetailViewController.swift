//
//  DetailViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var goodsIndex: Int?
    var goodsImages = [String]()
    
    @IBOutlet weak var bottomButtonView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet var labelHeight: NSLayoutConstraint!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureBottomButtonView()
        configureButtons()
        configurePageLabel()

        navigationController?.navigationBar.tintColor = .black
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        
        if let goodsIndex = goodsIndex {
            GoodsDataManager().fetchGoodsData(goodsIndex: String(goodsIndex), delegate: self)
        }        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize.height = (scrollView.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? scrollView.contentSize.height) + 50
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
    }
    
    func configurePageLabel() {
        pageLabel.backgroundColor = UIColor(white: 0, alpha: 0.2)
        pageLabel.layer.cornerRadius = 5
    }
    
    func setImagePageLabelText(_ currentPage: Int) {
        pageLabel.text = "\(currentPage) / \(goodsImages.count)"
    }

}

// MARK: - Networking
extension DetailViewController {
    func didFetchGoodsData(result: GoodsResult) {
        let goodsData = result.getGoodsDataRes
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
        return goodsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsImageCell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let url = URL(string: goodsImages[indexPath.row]) {
            cell.imageView.load(url: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 400)
    }
}
