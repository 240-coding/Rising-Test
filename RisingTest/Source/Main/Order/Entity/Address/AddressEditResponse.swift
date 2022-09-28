//
//  AddressEditResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/27.
//

import Foundation

struct AddressEditResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String
}
