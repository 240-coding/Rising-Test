//
//  HomeResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/24.
//

import Foundation

struct HomeResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: HomeResult
}

struct HomeResult: Decodable {
    let getHomeDataRes: [HomeData]
    let getMainPageImgRes: [MainPageImageResult]
}

struct HomeData: Decodable {
    let goodsIdx: Int
    let goodsName: String
    let goodsPrice: Int
    let goodsUpdatedAt: String
    let goodsUpdatedAtTime: String
    let address: String?
    let isSecurePayment: String
    let gimgs: [Gimg]
}

struct Gimg: Decodable {
    let goodsImgIdx: Int
    let goodsImgUrl: String
}

struct MainPageImageResult: Decodable {
    let mainPageImgUrl: String
}
