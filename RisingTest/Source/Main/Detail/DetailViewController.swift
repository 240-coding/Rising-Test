//
//  DetailViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bottomButtonView: UIView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureBottomButtonView()
        configureButtons()

        navigationController?.navigationBar.tintColor = .black
    }
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
