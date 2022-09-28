//
//  AddressRemoveViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/28.
//

import UIKit

class AddressRemoveViewController: UIViewController {
    
    var delegate: AddressRemoveDelegate?
    var addressIdx: Int?
    
    @IBOutlet var modalView: UIView!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var yesButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissViewControllerWhenTappedAround()
        view.backgroundColor = .black.withAlphaComponent(0.2)
        modalView.layer.cornerRadius = 10
        modalView.clipsToBounds = true
        configureButton(noButton)
        configureButton(yesButton)
    }
    
    func configureButton(_ button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "lightgray")?.cgColor
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        if let addressIdx = addressIdx {
            dismiss(animated: false) {
                self.delegate?.removeAddress(addressIdx: String(addressIdx))
            }
        } else {
            dismiss(animated: false) {
                print("Can't find addressIdx")
            }
        }
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

extension AddressRemoveViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
