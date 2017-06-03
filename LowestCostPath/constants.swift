//
//  constants.swift
//  LowestCostPath
//
//  Created by Karim Abdel-Malek on 06/02/17.
//  Copyright © 2017 NA. All rights reserved.
//

import Foundation

let thresholdLimit = 50


enum Result {
    case success(Any?)
    case failure(Error)
}

//CustomError
enum CustomError: LocalizedError {
    case valid
    case incorrectFormat
    case noData
    case unknown
    
    //Localized description
    var errorDescription: String? {
        switch self {
        case .valid:
            return "Valid matrix"
        case .incorrectFormat:
            return "Invalid matrix"
        case .noData:
            return "No input"
        case .unknown:
            return "Unkown error"
        }
    }
}
