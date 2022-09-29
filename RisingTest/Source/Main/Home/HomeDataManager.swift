//
//  HomeDataManager.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/24.
//

import Foundation
import Alamofire

class HomeDataManager {
    func fetchHomeData(delegate: HomeViewController) {
        let url = Constant.BASE_URL + "/home"
        
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else {
            return
        }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: HomeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchHomeData(result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
