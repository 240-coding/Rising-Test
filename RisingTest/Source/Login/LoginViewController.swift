//
//  LoginViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/19.
//

import UIKit

struct LoginCellData {
    let title: String
    let description: String
    let imageName: String
}
class LoginViewController: UIViewController {
    
    let cellIdentifier = "LoginCell"
    let loginCellData = [
        LoginCellData(title: "취향을 잇는 거래,\n번개장터", description: "요즘 유행하는 메이저 취향부터\n나만 알고싶은 마이너 취향까지", imageName: "login1"),
        LoginCellData(title: "안전하게\n취향을 잇습니다.", description: "번개톡, 번개페이로\n거래의 시작부터 끝까지 안전하게", imageName: "login2"),
        LoginCellData(title: "편리하게\n취향을 잇습니다.", description: "포장택배 서비스로\n픽업/포장/배송을 한번에", imageName: "login3"),
        LoginCellData(title: "번개장터에서\n취향을 거래해보세요.", description: "지금 바로 번개장터에서\n당신의 취향에 맞는 아이템들을 찾아보세요!", imageName: "login4")
    ]
    
    @IBOutlet weak var loginCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Collection View
        loginCollectionView.delegate = self
        loginCollectionView.dataSource = self
        
        pageControl.addTarget(self, action: #selector(pageValueDidChanged), for: .valueChanged)
        
        loginCollectionView.scrollToItem(at: NSIndexPath(item: pageControl.currentPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    // MARK: - Actions
    @objc func pageValueDidChanged() {
        let indexPath = IndexPath(row: pageControl.currentPage, section: 0)
        loginCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(round(value))
        }
    }
}

// MARK: - UICollectionView
extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? LoginCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = loginCellData[indexPath.row].title
        cell.descriptionLabel.text = loginCellData[indexPath.row].description
        cell.imageView.image = UIImage(named: loginCellData[indexPath.row].imageName) ?? UIImage()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
