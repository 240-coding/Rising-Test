//
//  AddressAddResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/27.
//

import Foundation

struct AddressAddResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: AddressAddResult
}

struct AddressAddResult: Decodable {
    var addressIdx: Int
}
