//
//  SportsAndLeisure.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/4/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class SportsAndLeisure: UITableViewController {
    
    var sportsAndLeisureData = [(String, String)]()
    
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!

    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product1Label.text = sportsAndLeisureData[0].0
        product2Label.text = sportsAndLeisureData[1].0
        product3Label.text = sportsAndLeisureData[2].0
        
        price1Label.text = sportsAndLeisureData[0].1
        price2Label.text = sportsAndLeisureData[1].1
        price3Label.text = sportsAndLeisureData[2].1

        
    }
}
