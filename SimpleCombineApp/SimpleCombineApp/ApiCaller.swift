//
//  ApiCaller.swift
//  SimpleCombineApp
//
//  Created by Mitya Kim on 12/2/24.
//


import Combine
import Foundation

final class ApiCaller {
    
    static let shared = ApiCaller()
    
    func fetchData() -> Future<[String], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                promise(.success(["Apple", "Netflix", "Microsoft", "Google", "Facebook"]))
            }
        }
    }
    
}
