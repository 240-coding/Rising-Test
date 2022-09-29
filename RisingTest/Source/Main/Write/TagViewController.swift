//
//  TagViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class TagViewController: UIViewController {
    
    var tags = [String]()
    
    @IBOutlet var textfield: UITextField!
    @IBOutlet var tagStackView: UIStackView!
    @IBOutlet var addButton: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagStackView.addBorders(edges: .bottom, color: UIColor(named: "lightgray")!, width: 1)
        addButton.addBorders(edges: .left, color: UIColor(named: "lightgray")!, width: 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = collectionView.contentSize.height + 50
        collectionView.reloadData()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Action
    @IBAction func addButtonTapped() {
        if let tag = textfield.text {
            if tags.count < 5 && !tags.contains(tag) {
                tags.append(tag)
            }
        }
        self.viewDidLayoutSubviews()
    }

}

extension TagViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.tagLabel.text = tags[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label: UILabel = {
            let label = UILabel()
            label.text = tags[indexPath.row]
            label.font = .systemFont(ofSize: 14)
            label.sizeToFit()
            
            return label
        }()
        return CGSize(width: label.frame.width + 40, height: 50)
    }
    
    
}
