//
//  Utilities.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/10/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class Utilities: UITableViewController {
    
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!
    
    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    
    var utilitiesData = [(String, String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product1Label.text = utilitiesData[0].0
        product2Label.text = utilitiesData[1].0
        product3Label.text = utilitiesData[2].0
        
        price1Label.text = utilitiesData[0].1
        price2Label.text = utilitiesData[1].1
        price3Label.text = utilitiesData[2].1
    }
    
    
    
}