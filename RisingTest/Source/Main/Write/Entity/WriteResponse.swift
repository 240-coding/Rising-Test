//
//  WriteResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/30.
//

import Foundation

struct WriteResponse: Decodable {
    var result: String
    var isSuccess: Bool
    var code: Int
    var message: String
}
