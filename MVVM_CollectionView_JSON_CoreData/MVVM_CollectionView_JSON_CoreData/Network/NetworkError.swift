//
//  NetworkError.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/2/24.
//


enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case noData
}
