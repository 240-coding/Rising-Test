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

        configureBottomButtonView()
        configureButtons()

        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
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
