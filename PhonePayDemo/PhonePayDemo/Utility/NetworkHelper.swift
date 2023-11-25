//
//  NetworkHelper.swift
//  PhonePayDemo
//
//  Created by Devaki Nandan Sharma on 25/11/23.
//

import Foundation

final class NetworkHelper {
    static let shared: NetworkHelper = NetworkHelper()
    
    private init() {
        
    }
    
    func getVenue(urlStr: String, queryItem: [String: String], completionHandler: @escaping (VenueListModel?, Error?)->Void) {
        
        guard Reachability.isConnectedToNetwork() else {
            print("Internet Connection not Available!")
            // get Venue From Local If available
            return
        }
        var url = URL(string: urlStr)!
        for item in queryItem {
            url.appendQueryItem(name: item.key, value: item.value)
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
              print("Error with fetching films: \(error)")
                completionHandler(nil, error)
              return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(response)")
                completionHandler(nil, error)
              return
            }
           
            if let data = data, let venue = try? JSONDecoder().decode(VenueListModel.self, from: data) {
                completionHandler(venue, nil)
            }            
        }
        task.resume()
    }    
}

extension URL {
    mutating func appendQueryItem(name: String, value: String?) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
}
