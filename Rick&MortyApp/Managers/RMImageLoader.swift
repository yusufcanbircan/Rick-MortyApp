//
//  RMImageLoader.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 15.03.2023.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    
    private let imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data,
                  error == nil,
                  let self = self
            else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }; task.resume()
    }
}
