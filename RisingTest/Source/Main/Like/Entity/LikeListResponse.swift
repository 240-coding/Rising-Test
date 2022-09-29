//
//  LikeListResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/30.
//

import Foundation

struct LikeListResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [LikeListResult]
}

struct LikeListResult: Decodable {
    var goodsLikeIdx: Int
    var updateAt: String
    var userImgUrl: String
    var img: String
    var userNickName: String
    var goodsIdx: Int
    var goodsName: String
    var goodsPrice: Int
    var isSecurePayment: String
}
