//
//  PlanetCell.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import UIKit
import CoreData

class PlanetCell: UITableViewCell {
    
    //MARK: Public properties
    @IBOutlet weak var planetNameLabel: UILabel!
    static let reuseIdentifier = "PlanetCell"
    
    //MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // this textcolor is to support dark mode
        planetNameLabel.textColor = .label
    }
    
    //MARK: Methods
    func setData(_ planetData: Planet) {
        planetNameLabel.text = planetData.name
        applyAccessibility(planetData)
    }
    
    func applyAccessibility(_ planetData: Planet) {
        planetNameLabel.accessibilityLabel = planetData.name
    }
}
