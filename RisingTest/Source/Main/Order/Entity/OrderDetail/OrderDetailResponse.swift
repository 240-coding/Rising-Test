//
//  OrderDetailResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import Foundation

struct OrderDetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: OrderDetailResult
}

struct OrderDetailResult: Decodable {
    var goodsIdx: Int
    var orderStatus: String
    var goodsPrice: Int
    var goodsName: String
    var orderTime: String
    var sellerName: String
    var orderPaymentMethod: String
    var orderPaymentBank: String?
    var orderTotalPrice: Int
    var orderGoodsPrice: Int
    var orderFee: Int
    var deliveryFee: Int
    var addressIdx: Int
    var userName: String
    var userPhoneNum: String
    var address: String
    var orderDeliveryReq: String?
}
