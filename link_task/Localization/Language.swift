//
//  Language.swift
//  Al-Rass
//
//  Created by admin on 17/09/2022.
//




import Foundation

enum Language: String {

    case english_us = "en"
    case arabic = "ar"
    
    var userSymbol: String {
        switch self {
        case .english_us:
            return "us"
        case .arabic:
            return "eg"
        }
    }
}

