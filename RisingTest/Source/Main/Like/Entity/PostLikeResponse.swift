//
//  LikeResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/30.
//

import Foundation

struct PostLikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: PostLikeResult
}

struct PostLikeResult: Decodable {
    var goodsLikeIdx: Int
}
