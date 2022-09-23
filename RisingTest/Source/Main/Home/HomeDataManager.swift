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
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: HomeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    // 수고용
                    debugPrint(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
