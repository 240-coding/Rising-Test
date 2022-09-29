//
//  CategoryResponse.swift
//  RisingTest
//
//  Created by 이서영 on 2022/09/29.
//

import Foundation

struct CategoryResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [CategoryResult]
}

struct CategoryResult: Decodable {
    var categoryIdx: Int
    var categoryName: String
    var options: [CategoryOption]
}

struct CategoryOption: Decodable {
    var categoryIdx: Int
    var categoryOptionIdx: Int
    var categoryOptionName: String
}
