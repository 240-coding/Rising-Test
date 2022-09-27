//
//  AddressEditRequest.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/27.
//

import Foundation

struct AddressEditRequest: Encodable {
    var userName: String
    var userPhoneNum: String
    var address: String
    var addressDetail: String
    var isBaseAddress: String
}
