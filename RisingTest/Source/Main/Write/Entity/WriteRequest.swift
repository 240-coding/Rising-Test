//
//  WriteRequest.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/30.
//

import Foundation
import UIKit

struct WriteRequest {
    var goodsAddress: String
    var goodsName: String
    var goodsContent: String
    var goodsPrice: Int
    var isSecurePayment: String
    var isDeliveryFee: String
    var goodsCount: Int
    var goodsCondition: String
    var isExchange: String
    var categoryOptionIdx: Int
    var categoryIdx: Int
    var tags: [WriteTag]
    var multipartfile: UIImage
}

struct WriteTag {
    var tagName: String
}
