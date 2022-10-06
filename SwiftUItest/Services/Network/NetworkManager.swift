//
//  NetworkManager.swift
//  SwiftUItest
//
//  Created by Линар Нигматзянов on 04/10/2022.
//

import Foundation

open class ApiCaller {
    static let shared = ApiCaller()
    
    public func makeAPIRequest<T: Decodable>(with urlString: String,
                                             _ successDataType: T.Type,
                                             _ completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { result, _, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            guard let data = result else { return }
            
            var decodedResult: T
            do {
                decodedResult = try JSONDecoder().decode(T.self, from: data)
                
                completionHandler(.success(decodedResult))
            } catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}
