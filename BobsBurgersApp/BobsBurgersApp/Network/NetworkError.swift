//
//  NetworkError.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//


enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case noData
}
