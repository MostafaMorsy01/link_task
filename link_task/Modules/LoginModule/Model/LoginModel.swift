//
//  LoginModel.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import Foundation

struct LoginModel: Codable {
    let id: Int?
    let authToken: String?
    let expires: Int?
}
