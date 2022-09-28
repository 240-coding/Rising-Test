//
//  OrderResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import Foundation

struct OrderResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: OrderResult
}

struct OrderResult: Decodable {
    var orderIdx: Int
}
