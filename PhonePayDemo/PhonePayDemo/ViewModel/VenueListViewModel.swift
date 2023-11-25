//
//  VenueListViewModel.swift
//  PhonePayDemo
//
//  Created by Devaki Nandan Sharma on 25/11/23.
//

import Foundation
class VenueListViewModel {
    weak var delegate: VenueListViewModelProtocol?
    
    var venueList: [Venues] = []
    var localVenueList: [Venues] = []
    
    func getVenue(lat: Double, long: Double, range: Int, page: Int, query: String) {
        self.delegate?.manageLoader(staus: true)
        let queryParam: [String: String] = [
            "per_page": "\(10)",
            "page": "\(1)",
            "client_id": "Mzg0OTc0Njl8MTcwMDgxMTg5NC44MDk2NjY5",
            "lat": "\(lat)",
            "lon": "\(long)",
            "range": "\(range)mi",
            "q": query
        ]
        
        NetworkHelper.shared.getVenue(urlStr: "https://api.seatgeek.com/2/venues", queryItem: queryParam) { [weak  self] venueListModel, error in
            guard let self = self else { return }
            
            self.delegate?.manageLoader(staus: false)
            if let error = error {
                // Show Error On UI
            }
            
            if let venueListModel = venueListModel {
                //Show Data On UI
                if let venue = venueListModel.venues {
                    self.venueList = venue
                    self.localVenueList = venue
                }
                self.delegate?.reloadView()
            }
        }
    }
    
    func applyFiler(searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
            self.localVenueList = self.venueList.filter({ venue in
               return venue.name?.lowercased().contains(searchText.lowercased()) ?? false
            })
        } else {
            self.localVenueList = self.venueList
        }
        self.delegate?.reloadView()
    }
}


protocol VenueListViewModelProtocol: AnyObject {
    func manageLoader(staus: Bool)
    func reloadView()
}
