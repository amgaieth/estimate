//
//  Restaurant.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/4/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class Restaurant: UITableViewController {
    
//    var restaurantData: [String:String] = [:]
    
    var restaurantData = [(String, String)]()
    
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!
    @IBOutlet weak var product4Label: UILabel!
    @IBOutlet weak var product5Label: UILabel!
    @IBOutlet weak var product6Label: UILabel!
    @IBOutlet weak var product7Label: UILabel!
    @IBOutlet weak var product8Label: UILabel!
    
    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    @IBOutlet weak var price4Label: UILabel!
    @IBOutlet weak var price5Label: UILabel!
    @IBOutlet weak var price6Label: UILabel!
    @IBOutlet weak var price7Label: UILabel!
    @IBOutlet weak var price8Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product1Label.text = restaurantData[0].0
        product2Label.text = restaurantData[1].0
        product3Label.text = restaurantData[2].0
        product4Label.text = restaurantData[3].0
        product5Label.text = restaurantData[4].0
        product6Label.text = restaurantData[5].0
        product7Label.text = restaurantData[6].0
        product8Label.text = restaurantData[7].0
        
        price1Label.text = restaurantData[0].1
        price2Label.text = restaurantData[1].1
        price3Label.text = restaurantData[2].1
        price4Label.text = restaurantData[3].1
        price5Label.text = restaurantData[4].1
        price6Label.text = restaurantData[5].1
        price7Label.text = restaurantData[6].1
        price8Label.text = restaurantData[7].1
        
    }
    
}
