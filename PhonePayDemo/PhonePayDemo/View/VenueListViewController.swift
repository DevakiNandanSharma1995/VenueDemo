//
//  VenueListViewController.swift
//  PhonePayDemo
//
//  Created by Devaki Nandan Sharma on 25/11/23.
//

import UIKit
import CoreLocation


class VenueListViewController: UIViewController {

    @IBOutlet weak var venueListTableView: UITableView!
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var locationSlider: UISlider!
    @IBOutlet weak var locationLbl: UILabel!
    
    let viewModel = VenueListViewModel()
    var range: Int  = 12
    var lat: Double = 0.0
    var long: Double = 0.0
    var page: Int = 1
    var query: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpView()
        LocationService.shared.delegate = self
        viewModel.delegate = self
    }
    
    func setUpView() {
        self.setUpTextFld()
        self.setUpTableViewDelegate()
        
    }
    
    func setUpTextFld() {
        self.searchTxtFld.layer.cornerRadius = self.searchTxtFld.bounds.height / 2
        self.searchTxtFld.delegate = self
    }
    func setUpTableViewDelegate() {
        self.venueListTableView.delegate = self
        self.venueListTableView.dataSource = self
    }

}


extension VenueListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.localVenueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VenueListCell") as? VenueListCell else { return UITableViewCell() }
        let model = self.viewModel.localVenueList[indexPath.row]
        cell.showData(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension VenueListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var search = textField.text!
        if let r = Range(range, in: search){
            search.removeSubrange(r) // it will delete any deleted string.
        }
        search.insert(contentsOf: string, at: search.index(search.startIndex, offsetBy: range.location)) // it will insert any text.
        self.query = search
        self.viewModel.applyFiler(searchText: search)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension VenueListViewController: LocationServiceDelegate {
    func onLocationUpdate(location: CLLocation) {
            print("Current Location : \(location)")
        self.lat = location.coordinate.latitude
        self.long = location.coordinate.longitude
        self.callVenueApi()
        }

        func onLocationDidFailWithError(error: Error) {
            print("Error while trying to update device location : \(error)")
        }
    
    func callVenueApi() {
        self.viewModel.getVenue(lat: self.lat, long: self.long, range: self.range, page: self.page, query: self.query)
    }
}


extension VenueListViewController: VenueListViewModelProtocol {
    func manageLoader(staus: Bool) {
        if staus {
            self.showLoader()
        } else {
            self.hideLoader()
        }
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.venueListTableView.reloadData()
        }
    }
    
}
