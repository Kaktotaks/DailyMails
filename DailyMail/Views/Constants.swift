//
//  Constants.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 02.10.2021.
//

import Foundation

struct Constants {
    
    struct Titles{
        static let mediaTitle = "New York Times"
        static let favouritesTitle = "Favourites"
    }
    
    struct Network{
        static let mostViewedURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key="
        static let mostEmailedURL = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key="
        static let mostSharedURL = "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json?api-key="
        static let apiKey = "vuIfURUfUeJfm6S5iYK17hxXNBPBOQEz"
        static let baseURL = "https://s3-symbol-logo.tradingview.com/new-york-times--600.png"
        
    }
    
    struct CellsIDs{
        static let customMediasTableViewCell = "CustomMediasTableViewCell"
    }
    

}
