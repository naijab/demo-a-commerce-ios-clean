//
//  ErrorType.swift
//  A-Commerce
//
//  Created by Nattapon Pondongnok on 7/6/2564 BE.
//

import Foundation

enum ErrorType: String, LocalizedError {
    case fetchError = "Something wrong"
    
    var errorDescription: String? {
        return self.rawValue
    }
}
