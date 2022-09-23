//
//  LoginResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/23.
//

import Foundation

struct LoginResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: LoginReponseResult
}

struct LoginReponseResult: Decodable {
    var userIdx: Int
    var jwt: String
}
