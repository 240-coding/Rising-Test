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
    
    func postGoods(writeRequest: WriteRequest, delegate: WriteViewController) {
        let url = Constant.BASE_URL + "/goods"
        
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else {
            return
        }
        let headers: HTTPHeaders = [
//            "Content-Type" : "application/json",
            "X_ACCESS_TOKEN": userToken
        ]
        
        let parameters: [String: Any] = [
            "goodsAddress": writeRequest.goodsAddress,
            "goodsName": writeRequest.goodsName,
            "goodsContent": writeRequest.goodsContent,
            "goodsPrice": writeRequest.goodsPrice,
            "isSecurePayment": writeRequest.isSecurePayment,
            "isDeliveryFee": writeRequest.isDeliveryFee,
            "goodsCount": writeRequest.goodsCount,
            "goodsCondition": writeRequest.goodsCondition,
            "IsExchange": writeRequest.isExchange,
            "categoryOptionIdx": writeRequest.categoryOptionIdx,
            "categoryIdx": writeRequest.categoryIdx,
            "tags": writeRequest.tags.map{ $0.tagName }
//            "multipartfile: UIImage
        ]
        
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if key == "tags" {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: "\(key)[tagName]" as String)
                } else {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            if let image = writeRequest.multipartfile.pngData() {
                multipartFormData.append(image, withName: "multipartfile", fileName: "\(image).png", mimeType: "image/png")
            }
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers)
        .validate()
        .responseDecodable(of: WriteResponse.self){ response in
            switch response.result {
            case .success(let response):
                print(response.result)
                delegate.didPostGoods()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
