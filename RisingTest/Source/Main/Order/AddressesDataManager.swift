//
//  AddressesDataManager.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import Foundation
import Alamofire

class AddressesDataManager {
    func fetchAddressesData(delegate: OrderViewController) {
        let url = Constant.BASE_URL + "/app/addresses"
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else { return }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: AddressesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchAddressesData(result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
