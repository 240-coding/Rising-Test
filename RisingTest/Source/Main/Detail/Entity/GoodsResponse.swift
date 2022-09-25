//
//  GoodsResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/25.
//

import Foundation

// MARK: - GoodsResponse
struct GoodsResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: GoodsResult
}

// MARK: - Result
struct GoodsResult: Codable {
    let getGoodsDataRes: GetGoodsDataRes
    let getStoreGoodsRes: [GetStoreGoodsRe]
    let getStoreReviewRes: [GetStoreReviewRe]
}

// MARK: - GetGoodsDataRes
struct GetGoodsDataRes: Codable {
    let goodsIdx, userIdx: Int
    let goodsName, goodsContent: String
    let goodsPrice: Int
    let goodsUpdatedAt, goodsUpdatedAtTime: String
    let goodsAddress: String?
    let goodsCount: Int
    let goodsCondition: String
    let likes: [Like]
    let imgs: [Img]
    let isSecurePayment, isDeilveryFee, isExchange: String
}

// MARK: - Img
struct Img: Codable {
    let goodsIdx: Int
    let goodsImgUrl: String
}

// MARK: - Like
struct Like: Codable {
    let likes: Int
}

// MARK: - GetStoreGoodsRe
struct GetStoreGoodsRe: Codable {
    let goodsIdx, userIdx: Int
    let goodsName: String
    let goodsPrice: Int
    let getGoodsImgRes: [Img]
}

// MARK: - GetStoreReviewRe
struct GetStoreReviewRe: Codable {
    let reviewIdx: Int
    let reviewContent: String
    let score: Double
    let reviewCreatedAt, reviewUpdatedAtTime: String
}
