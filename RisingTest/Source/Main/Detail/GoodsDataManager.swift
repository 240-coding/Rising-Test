//
//  GoodsDataManager.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/25.
//

import Foundation
import Alamofire

class GoodsDataManager {
    func fetchGoodsData(goodsIndex: String, delegate: DetailViewController) {
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
                    delegate.didFetchGoodsData(result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
