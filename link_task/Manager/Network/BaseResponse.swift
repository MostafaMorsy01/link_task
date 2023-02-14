//
//  BaseResponse.swift
//  El Rass
//
//  Created by admin on 16/08/2022.
//

import Foundation
struct BaseResponse<T:Codable> : Codable {
        let message: String?
        let status: Int?
        let data: T?
        

        enum CodingKeys: String, CodingKey {
            case message = "msg"
            case status = "status"
            case data = "data"
            
        }
    
    init() {
        self.message = ""
        self.status = 0
        self.data = T.self as? T
    }
}

