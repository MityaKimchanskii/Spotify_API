//
//  ResponseError.swift
//  RestAPI
//
//  Created by Mitya Kim on 5/13/23.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case thrownError
    case noData
    case unableToDecode
}
