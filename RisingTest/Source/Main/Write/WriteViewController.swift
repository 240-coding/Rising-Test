//
//  WriteViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/20.
//

import UIKit

protocol TagDelegate {
    func loadUserTags(tags: [String])
}

protocol OptionDelegate {
    func loadSelectedOptions(amount: Int, condition: String, isExchange: String)
}

class WriteViewController: UIViewController {
    
    var writeRequest = WriteRequest(goodsAddress: "서울특별시 서대문구 신촌동", goodsName: "", goodsContent: "", goodsPrice: 0, isSecurePayment: "N", isDeliveryFee: "N", goodsCount: 1, goodsCondition: "0", isExchange: "N", categoryOptionIdx: 0, categoryIdx: 0, tags: [], multipartfile: UIImage())
    
    var selectedImages = [UIImage]()
    var tags = [String]()
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet var optionView: [UIView]!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var priceWonImageView: UIImageView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var deliveryFeeButton: UIButton!
    
    @IBOutlet weak var optionSelectButton: UIButton!
    @IBOutlet weak var optionLabel: UILabel!
    
    @IBOutlet var textView: UITextView!
    
    @IBOutlet weak var bottomButtonView: UIView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var writeButton: UIButton!
    
    @IBOutlet weak var payWarningImageView: UIImageView!
    @IBOutlet weak var payWarningLabel: UILabel!
    
    var textViewHeight = 400.0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTextViews()
        configureBottomButtonView()
        configureButtons()
        configureCollectionView()
        
//        self.dismissKeyboardWhenTappedAround()
        
        imagePicker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(getSelectedCategoryIdx), name: Notification.Name.category, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height = scrollView.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? scrollView.contentSize.height
        
        scrollView.contentSize.height = height
        view.layoutIfNeeded()
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
    
    func configureTextViews() {
        optionView.forEach { view in
            view.addBorders(edges: .bottom, color: UIColor(named: "lightgray") ?? .systemGray3, width: 1.0)
        }
        
        nameTextField.delegate = self
        priceTextField.delegate = self
        
        nameTextField.tag = 0
        tagButton.tag = 2
        priceTextField.tag = 3
        
        optionSelectButton.layer.cornerRadius = 3
        optionSelectButton.layer.borderWidth = 1
        optionSelectButton.layer.borderColor = UIColor(named: "lightgray")?.cgColor
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
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "WriteUploadCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UploadCell")
        collectionView.register(UINib(nibName: "WritePhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    // MARK: - Actions
    @IBAction func pressedCategoryButton(_ sender: Any) {
        guard let categoryViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController else {
            return
        }
        navigationController?.pushViewController(categoryViewController, animated: true)
    }
    
    @IBAction func pressedTagButton(_ sender: UIButton) {
        guard let tagViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "TagViewController") as? TagViewController else {
            return
        }
        tagViewController.delegate = self
        tagViewController.tags = self.tags
        navigationController?.pushViewController(tagViewController, animated: true)
    }
    
    @IBAction func pressedDeliveryFeeButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            sender.tintColor = UIColor(named: "red") ?? UIColor()
            writeRequest.isDeliveryFee = "Y"
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            sender.tintColor = UIColor(named: "lightgray") ?? .systemGray3
            writeRequest.isDeliveryFee = "N"
        }
    }
    
    @IBAction func pressedOptionButton(_ sender: UIButton) {
        guard let optionViewController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(withIdentifier: "OptionViewController") as? OptionViewController else {
            return
        }
        optionViewController.modalPresentationStyle = .pageSheet
        optionViewController.delegate = self
        
        if #available(iOS 15.0, *) {
            if let sheet = optionViewController.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 15
            }
        }
        self.present(optionViewController, animated: true, completion: nil)
    }
    
    @IBAction func pressedPayButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.layer.borderColor = UIColor(named: "red")?.cgColor
            payWarningImageView.isHidden = true
            payWarningLabel.text = "내 상품에 안전결제 배지가 표시돼요"
            payWarningLabel.textColor = .black
            writeRequest.isSecurePayment = "Y"
        } else {
            sender.layer.borderColor = UIColor(named: "lightgray")?.cgColor
            payWarningImageView.isHidden = false
            payWarningLabel.text = "안전결제를 거부하면 주의 안내가 표시돼요"
            payWarningLabel.textColor = UIColor(named: "red") ?? UIColor()
            writeRequest.isSecurePayment = "N"
        }
    }
    
    @objc func uploadCellTapped() {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func getSelectedCategoryIdx(_ notification: Notification) {
        guard let data = notification.userInfo as? [String: String] else {
            return
        }
        let selectedCategory = "\(data["categoryName"] ?? "") > \(data["categoryOptionName"] ?? "")"
        categoryButton.setTitle(selectedCategory, for: .normal)
        categoryButton.setTitleColor(.black, for: .normal)
        
        if let categoryIdx = Int(data["categoryIdx"] ?? ""), let categoryOptionIdx = Int(data["categoryOptionIdx"] ?? "") {
            writeRequest.categoryIdx = categoryIdx
            writeRequest.categoryOptionIdx = categoryOptionIdx
        }
    }
    
    @IBAction func pressedWriteButton(sender: UIButton) {
        if let goodsName = nameTextField.text, let priceText = priceTextField.text, let price = Int(priceText), let content = textView.text, let image = selectedImages.first {
            writeRequest.goodsName = goodsName
            writeRequest.goodsPrice = price
            writeRequest.goodsContent = content
            writeRequest.multipartfile = image
            
            writeRequest.tags = tags.map{ WriteTag(tagName: $0 )}
            
            WriteDataManager().postGoods(writeRequest: writeRequest, delegate: self)
        } else {
            print("no data")
        }
        
    }
}
// MARK: - Networking
extension WriteViewController {
    func didPostGoods() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Custom Delegate
extension WriteViewController: TagDelegate {
    func loadUserTags(tags: [String]) {
        self.tags = tags
        if !tags.isEmpty {
            var tagButtonText = ""
            for tag in tags {
                tagButtonText += "#\(tag)\t"
            }
            tagButton.setTitle(tagButtonText, for: .normal)
            tagButton.setTitleColor(.black, for: .normal)
            tagButton.setImage(UIImage(), for: .normal)
        } else {
            tagButton.setTitle("태그", for: .normal)
            tagButton.setTitleColor(.systemGray3, for: .normal)
            tagButton.setImage(UIImage(systemName: "number"), for: .normal)
        }
        
    }
}

extension WriteViewController: OptionDelegate {
    func loadSelectedOptions(amount: Int, condition: String, isExchange: String) {
        optionLabel.text = "\(amount)개﹒\(condition == "0" ? "중고상품" : "새상품")﹒\(isExchange == "N" ? "교환불가" : "교환가능")"
        
        writeRequest.goodsCount = amount
        writeRequest.goodsCondition = condition
        writeRequest.isExchange = isExchange
    }
}

// MARK: - UICollectionView
extension WriteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as? WriteUploadCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageCountLabel.text = "\(selectedImages.count)/12"
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? WritePhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = selectedImages[indexPath.row - 1]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            imagePicker.modalPresentationStyle = .fullScreen
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
}
// MARK: - Image Picker Delegate
extension WriteViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImages.append(image)
            self.dismiss(animated: true, completion: {
                self.collectionView.reloadData()
            })
        }
    }
}

// MARK: - UITextFieldDelegate
extension WriteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        optionView[textField.tag].addBorders(edges: .bottom, color: .black, width: 1.0)
        
        if textField.tag == 3 {
            priceWonImageView.tintColor = .black
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        optionView[textField.tag].addBorders(edges: .bottom, color: UIColor(named: "lightgray") ?? .systemGray3, width: 1.0)
        
        if textField.tag == 3 {
            priceWonImageView.tintColor = UIColor(named: "lightgray") ?? .systemGray3
        }
    }
}
