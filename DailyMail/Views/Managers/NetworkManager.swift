//
//  Manager.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 02.10.2021.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    //MARK: - Network request for reloading mostViewed
    func requestMostViewed(completion: @escaping(([Viewed]) -> ())) {
        let url = "\(Constants.Network.mostViewedURL)\(Constants.Network.apiKey)"
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(ViewedResult.self, from: responce.data!){
                let mostVieweds = data.vieweds ?? []
                completion(mostVieweds)
            }
        }
    }
    
    //MARK: - Network request for reloading mostEmailed
    func requestMostEmailed(completion: @escaping(([Emailed]) -> ())) {
        let url = "\(Constants.Network.mostEmailedURL)\(Constants.Network.apiKey)"
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(EmailedResult.self, from: responce.data!){
                let mostEmaileds = data.emaileds ?? []
                completion(mostEmaileds)
            }
        }
    }
    
    //MARK: - Network request for reloading mostShared
    func requestMostShared(completion: @escaping(([Shared]) -> ())) {
        let url = "\(Constants.Network.mostSharedURL)\(Constants.Network.apiKey)"
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(SharedResult.self, from: responce.data!){
                let mostShareds = data.shareds ?? []
                completion(mostShareds)
            }
        }
    }
    
    
//    func getMostShared(completion: @escaping ([Shared]?) -> Void ) {
//        let urlString = "\(Constants.Network.mostSharedURL)\(Constants.Network.apiKey)"
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard error == nil, let data = data else {
//                completion(nil)
//                return
//            }
//
//            let sharedResult = try? JSONDecoder().decode(SharedResult.self, from: data)
//            sharedResult == nil ? completion(nil) : completion(sharedResult!.shareds)
//        }.resume()
//    }
}

//class ApiService {
//    private var dataTask: URLSessionDataTask?
//
//    func getMostShared(completion: (Result<Shared, Error>) -> Void) {
//        let mostSharedURL = "\(Constants.Network.mostSharedURL)\(Constants.Network.apiKey)"
//
//        guard let url = URL(string: mostSharedURL) else {return}
//
//
//        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                completion(.failure(error))
//                print("DataTask error: \(error.localizedDescription)")
//                return
//            }
//            guard let response = response as? HTTPURLResponse else {
//                print("Empty Response")
//                return
//            }
//
//            guard let data = data else {
//                print("Empty Data")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let jsonData = try decoder.decode(SharedResult.self, from: data)
//
//                DispatchQueue.main.async {
//                    completion(.success(jsonData))
//                }
//
//            } catch let error {
//                completion(.failure(error))
//            }
//
//
//        }
//        dataTask?.resume()
//
//    }
//
//
//}
