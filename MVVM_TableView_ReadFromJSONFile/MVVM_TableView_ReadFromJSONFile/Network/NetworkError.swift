//
//  NetworkError.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import UIKit

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case noData
}


