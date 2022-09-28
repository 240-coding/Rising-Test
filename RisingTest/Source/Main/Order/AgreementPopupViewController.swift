//
//  AgreementPopupViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

class AgreementPopupViewController: UIViewController {
    
    @IBOutlet var modalView: UIView!
    @IBOutlet var okayButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissViewControllerWhenTappedAround()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true
        configureButton()
    }
    
    func configureButton() {
        okayButton.layer.borderWidth = 1
        okayButton.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func dismissViewControllerWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissViewController))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: false, completion: nil)
    }
    
}

extension AgreementPopupViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
