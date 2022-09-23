//
//  LoginViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/19.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

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
    
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var otherLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Collection View
        loginCollectionView.delegate = self
        loginCollectionView.dataSource = self
        
        pageControl.addTarget(self, action: #selector(pageValueDidChanged), for: .valueChanged)
        
        loginCollectionView.scrollToItem(at: NSIndexPath(item: pageControl.currentPage, section: 0) as IndexPath, at: .right, animated: true)
        
        configureLoginButton()
    }
    
    func configureLoginButton() {
        kakaoLoginButton.setRoundCorner()
        appleLoginButton.setRoundCorner()
        appleLoginButton.layer.borderColor = UIColor.black.cgColor
        appleLoginButton.layer.borderWidth = 1
    }
    // MARK: - Actions
    @objc func pageValueDidChanged() {
        let indexPath = IndexPath(row: pageControl.currentPage, section: 0)
        loginCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    @IBAction func pressKakaoLogin() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")

                if let myToken = oauthToken?.accessToken {
                    LoginDataManager().getKakaoLogin(accessToken: myToken, delegate: self)
                }
            }
        }

    }
}
// MARK: - Networking
extension LoginViewController {
    func didSuccessLogin(_ result: LoginReponseResult) {
        UserDefaults.standard.set(true, forKey: "isLogin")
        UserDefaults.standard.set(result.jwt, forKey: "KakaoLoginUserIdentifier")
        
        let mainStoryboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        let mainTabBarController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
        self.changeRootViewController(mainTabBarController)
    }
}

// MARK: - Banner
extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.frame.size.width != 0 {
            let value = (scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(round(value))
        }
    }
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loginCellData.count
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
