//
//  VenueListCell.swift
//  PhonePayDemo
//
//  Created by Devaki Nandan Sharma on 25/11/23.
//

import UIKit

class VenueListCell: UITableViewCell {
    
    @IBOutlet weak var venueLogo: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.venueLogo.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func showData(model: Venues) {
        self.nameLbl.text = model.name ?? ""
        self.locationLbl.text = "\(model.address ?? ""), \(model.city ?? "")"
    }
}
