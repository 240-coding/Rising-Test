//
//  LikeDataManager.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/30.
//

import Foundation
import Alamofire

protocol LikeDelegate {
    func didFetchLikeListData(result: [LikeListResult])
    
    func didPostLike(goodsIdx: Int, result: PostLikeResult)
    
    func didPatchLike(result: String)
}

class LikeDataManager {
    func fetchLikeList(delegate: LikeDelegate) {
        let url = Constant.BASE_URL + "/store-likes"
        
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else {
            return
        }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseDecodable(of: LikeListResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchLikeListData(result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func postLike(goodsIdx: Int, delegate: LikeDelegate) {
        let url = Constant.BASE_URL + "/store-likes"
        
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else {
            return
        }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        let parameters = [
            "goodsIdx": goodsIdx
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: PostLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didPostLike(goodsIdx: goodsIdx, result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func patchLike(goodsLikeIdx: Int, delegate: LikeDelegate) {
        let url = Constant.BASE_URL + "/store-likes"
        
        guard let userToken = UserDefaults.standard.string(forKey: "KakaoLoginUserIdentifier") else {
            return
        }
        let headers: HTTPHeaders = [
            "X_ACCESS_TOKEN": userToken
        ]
        let parameters = [
            "goodsLikeIdx": goodsLikeIdx
        ]
        
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .validate()
            .responseDecodable(of: PatchLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didPatchLike(result: response.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
