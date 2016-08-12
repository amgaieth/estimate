//
//  Clothing.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/11/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class Clothing: UITableViewController {
    
    var clothingData = [(String, String)]()
    
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!
    @IBOutlet weak var product4Label: UILabel!
    
    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    @IBOutlet weak var price4Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        product1Label.text = clothingData[0].0
        product2Label.text = clothingData[1].0
        product3Label.text = clothingData[2].0
        product4Label.text = clothingData[3].0
        
        price1Label.text = clothingData[0].1
        price2Label.text = clothingData[1].1
        price3Label.text = clothingData[2].1
        price4Label.text = clothingData[3].1
        
    }
    

    
}
