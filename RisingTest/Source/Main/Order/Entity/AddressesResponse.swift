//
//  AddressesResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/26.
//

import Foundation

struct AddressesResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [AddressesResult]
}

struct AddressesResult: Decodable {
    var addressIdx: Int
    var userName: String
    var address: String
    var addressDetail: String
    var userPhoneNum: String
    var isBaseAddress: String
}
