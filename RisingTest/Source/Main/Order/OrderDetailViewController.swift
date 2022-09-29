//
//  OrderDetailViewController.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import UIKit

struct GoodsOrderData {
    var goodsImage: String
    var goodsPrice: String
    var goodsName: String
}

class OrderDetailViewController: UIViewController {
    
    var orderIdx: Int?
    
    var goodsData = GoodsOrderData(goodsImage: "", goodsPrice: "", goodsName: "")
    
    let payTitle = ["거래방법", "주문번호", "주문일시", "판매자", "결제수단", "결제금액"]
    var payData = Array(repeating: "", count: 6)
    
    let deliveryTitle = ["수령인", "연락처", "배송지"]
    var deliveryData = Array(repeating: "", count: 10)
    
    var requestData = ""
    
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        
        let identifier = String(describing: OrderDetailHeaderView.self)
        let headerView = Bundle.main.loadNibNamed(identifier, owner: self)
        guard let header = headerView?.first as? OrderDetailHeaderView else { return }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = header
        
        if let orderIdx = orderIdx {
            print(orderIdx)
            OrderDataManager().fetchOrderDetail(orderIndex: String(orderIdx), delegate: self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.frame.width, height: 70)
    }

    // MARK: - Configure UI
    func configureNavigationBar() {
        navigationBar.tintColor = .black
        navigationBar.backgroundColor = .white

        let item = UINavigationItem()
        let closeBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissViewController))

        item.title = "주문상세내역"
        item.rightBarButtonItem = closeBarButtonItem

        navigationBar.items = [item]
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = .clear
            appearance.shadowImage = UIImage()
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    // MARK: - Actions
    @objc func dismissViewController() {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
// MARK: - Networking
extension OrderDetailViewController {
    func didFetchOrderDetail(result: OrderDetailResult) {
        guard let orderIdx = orderIdx else { return }
        payData = ["택배거래", String(orderIdx), result.orderTime, result.sellerName, result.orderPaymentMethod, "\(String(result.orderTotalPrice).insertComma)원"]
        deliveryData = [result.userName, result.userPhoneNum, result.address]
        requestData = result.orderDeliveryReq ?? "문앞"
        
        goodsData.goodsName = result.goodsName
        goodsData.goodsPrice = String(result.goodsPrice).insertComma + "원"
        
        OrderDataManager().fetchGoodsImage(goodsIndex: String(result.goodsIdx), delegate: self)
    }
    
    func didFetchGoodsImage(result: String?) {
        if let result = result {
            goodsData.goodsImage = result
            
            guard let header = tableView.tableHeaderView as? OrderDetailHeaderView else {
                return
            }
            guard let url = URL(string: result) else { return }
            header.imageView.load(url: url)
            header.priceLabel.text = goodsData.goodsPrice
            header.nameLabel.text = goodsData.goodsName
            
            tableView.reloadData()
        }
    }
}
// MARK: - UITableView
extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return 6
        } else if section == 1 {
            return 3
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCell") as? OrderDetailTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.titleLabel.text = payTitle[indexPath.row]
            cell.contentLabel.text = payData[indexPath.row]
        } else if indexPath.section == 1 {
            cell.titleLabel.text = deliveryTitle[indexPath.row]
            cell.contentLabel.text = deliveryData[indexPath.row]
            cell.titleLabel.textColor = UIColor(named: "gray")
            cell.contentLabel.isHidden = false
        } else {
            cell.titleLabel.text = requestData
            cell.titleLabel.textColor = .black
            cell.contentLabel.isHidden = true
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = String(describing: OrderDetailSectionHeaderView.self)
        let sectionHeaderView = Bundle.main.loadNibNamed(identifier, owner: self)
        guard let secionHeader = sectionHeaderView?.first as? OrderDetailSectionHeaderView else { return UIView() }
        
        if section == 0 {
            secionHeader.titleLabel.text = "거래정보"
            secionHeader.button.setTitle("거래취소하기", for: .normal)
            secionHeader.seperatorView.isHidden = true
        } else if section == 1 {
            secionHeader.titleLabel.text = "배송정보"
            secionHeader.button.setTitle("수정", for: .normal)
        } else {
            secionHeader.titleLabel.text = "배송요청사항"
            secionHeader.button.setTitle("수정", for: .normal)
        }
        
        return secionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
//    head
    
    
}
