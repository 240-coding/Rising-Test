//
//  LoginDataManager.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/23.
//

import Foundation
import Alamofire

class LoginDataManager {
    func getKakaoLogin(accessToken: String, delegate: LoginViewController) {
        let headers: HTTPHeaders = [
            "ACCESS_TOKEN": accessToken
        ]
        
        AF.request("\(Constant.BASE_URL)/auth/kakao/callback", method: .get, headers: headers)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess {
                        delegate.didSuccessLogin(response.result)
                    } else {
                        debugPrint(response)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
            }
    }
}
