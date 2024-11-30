//
//  NetworkError.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import UIKit


enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "There unable to decode the data."
        }
    }
}

