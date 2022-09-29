//
//  WriteDataManager.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import Foundation
import Alamofire

class WriteDataManager {
    func fetchCategories(delegate: CategoryViewController) {
        let url = Constant.BASE_URL + "/goods/categorys"
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: CategoryResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchCategoryData(result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
