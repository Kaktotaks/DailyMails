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
    
}

