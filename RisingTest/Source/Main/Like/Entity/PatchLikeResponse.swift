//
//  PatchLikeResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/30.
//

import Foundation

struct PatchLikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: String
}

//struct PathLikeResult: Decodable {
//    var r
//}
