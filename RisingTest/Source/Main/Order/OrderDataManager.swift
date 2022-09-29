//
//  OrderDataManager.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import Foundation
import Alamofire

class OrderDataManager {
    func postOrder(parameters: OrderRequest, delegate: OrderViewController) {
        let url = Constant.BASE_URL + "/app/orders"
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else { return }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: headers)
            .validate()
            .responseDecodable(of: OrderResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didPostOrder(orderResult: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchOrderDetail(orderIndex: String, delegate: OrderDetailViewController) {
        let url = Constant.BASE_URL + "/app/orders/\(orderIndex)"
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else {
            return
        }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: OrderDetailResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchOrderDetail(result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func fetchGoodsImage(goodsIndex: String, delegate: OrderDetailViewController) {
        let url = Constant.BASE_URL + "/goods/\(goodsIndex)"
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else {
            return
        }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: GoodsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchGoodsImage(result: response.result.getGoodsDataRes.imgs.first?.goodsImgUrl)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
