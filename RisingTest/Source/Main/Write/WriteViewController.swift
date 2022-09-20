//
//  WriteViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/20.
//

import UIKit

class WriteViewController: UIViewController {
    
    @IBOutlet weak var bottomButtonView: UIView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureBottomButtonView()
        configureButtons()
    }
    
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
        self.dismiss(animated: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
