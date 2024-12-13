//
//  NetworkError.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

enum NetworkError: Error, Equatable {
    case noData
    case invalidURL
    case invalidResponce
    case thrownError(Error)
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData),
             (.invalidURL, .invalidURL),
             (.invalidResponce, .invalidResponce):
            return true
        case (.thrownError(let lhsError), .thrownError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
