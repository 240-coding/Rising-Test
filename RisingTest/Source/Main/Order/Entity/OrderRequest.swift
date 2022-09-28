//
//  OrderRequest.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import Foundation

struct OrderRequest: Encodable {
    var goodsIdx: Int
    var addressIdx: Int
    var orderDeliveryReq: String
    var goodsPrice: Int
    var orderFee: Int
    var deliveryFee: Int
    var orderTotalPrice: Int
    var orderPaymentMethod: String
    var orderPaymentBank: String?
}
