//
//  SearchChildViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/23.
//

import UIKit

class SearchChildViewController: UIViewController {
    
    let list = ["아이폰", "아이패드", "맥북", "아이폰", "아이패드", "맥북", "아이폰", "아이패드", "맥북"]
    let category = ["스타굿즈", "여성가방", "피규어/인형", "스니커즈", "닌텐도/NDS/Wii", "카메라/DSLR", "시계", "인테리어", "헬스/요가/필라테스", "CD/DVD/LP", "골프", "자전거"]
    
    @IBOutlet weak var recentCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }
    
    func setCollectionView() {
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
}

extension SearchChildViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == categoryCollectionView ? category.count : list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recentCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentCell", for: indexPath) as? SearchRecentCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.wordLabel.text = list[indexPath.row]
            
            return cell
        } else if collectionView == popularCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCell", for: indexPath) as? SearchPopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.rankLabel.text = "0\(indexPath.row)"
            cell.wordLabel.text = list[indexPath.row]
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? SearchCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = UIImage(named: "category\(indexPath.row+1)")
            cell.nameLabel.text = category[indexPath.row]
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollectionView {
            return CGSize(width: (collectionView.bounds.width - 8 * 4) / 4, height: collectionView.frame.height / 3 - 8)
        }
        
        let label: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = list[indexPath.row]
            label.sizeToFit()
            return label
        }()
        let size = label.frame.size
        
        if collectionView == recentCollectionView {
            return CGSize(width: size.width + 24 + 25, height: size.height + 24)
        } else {
            return CGSize(width: size.width + 24 + 60, height: size.height + 24)
        }
        
    }
    
}
