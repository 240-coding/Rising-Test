//
//  WriteViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/20.
//

import UIKit

class WriteViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var bottomButtonView: UIView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var payWarningImageView: UIImageView!
    @IBOutlet weak var payWarningLabel: UILabel!
    
    var textViewHeight = 400.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureBottomButtonView()
        configureButtons()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "WriteCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "WriteView")
    }
    
    // MARK: - Configure UI
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(dismissViewController))
        let rightButton = UIBarButtonItem(title: "직거래시 가능 지역", style: .plain, target: self, action: nil)
        rightButton.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
        rightButton.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 14)], for: .highlighted)
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureBottomButtonView() {
        bottomButtonView.layer.borderWidth = 1
        bottomButtonView.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }
    func configureButtons() {
        payButton.layer.cornerRadius = 5
        writeButton.layer.cornerRadius = 5
        payButton.layer.borderColor = UIColor(named: "lightgray")?.cgColor
        payButton.layer.borderWidth = 1
    }
    
    // MARK: - Actions
    
    @IBAction func pressedPayButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.layer.borderColor = UIColor(named: "red")?.cgColor
            payWarningImageView.isHidden = true
            payWarningLabel.text = "내 상품에 안전결제 배지가 표시돼요"
            payWarningLabel.textColor = .black
        } else {
            sender.layer.borderColor = UIColor(named: "lightgray")?.cgColor
            payWarningImageView.isHidden = false
            payWarningLabel.text = "안전결제를 거부하면 주의 안내가 표시돼요"
            payWarningLabel.textColor = UIColor(named: "red") ?? UIColor()
        }
    }

}

// MARK: - UICollectionView
extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WriteCell", for: indexPath) as? WriteCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextViewCell", for: indexPath) as? TextViewCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = 400.0
        
        if indexPath.row == 1 {
            height = textViewHeight
        }
        return CGSize(width: view.frame.width, height: height)
    }
    
    // Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "WriteView", for: indexPath) as? WriteCollectionReusableView else {
                return UICollectionReusableView()
            }
            return headerView
        default:
            assert(false, "test")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
}

extension WriteViewController: TextViewCollectionViewCellDelegate {
    func updateCollectionViewCellHeight(_ textView: UITextView) {
        self.textViewHeight = textView.frame.height
//        collectionView.reloadData()
    }
}
