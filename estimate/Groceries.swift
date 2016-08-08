//
//  Groceries.swift
//  estimate
//
//  Created by Anouar Mgaieth on 8/4/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit

class Groceries: UITableViewController {
    
    var groceriesData = [(String, String)]()
    
    @IBOutlet weak var product1Label: UILabel!
    @IBOutlet weak var product2Label: UILabel!
    @IBOutlet weak var product3Label: UILabel!
    @IBOutlet weak var product4Label: UILabel!
    @IBOutlet weak var product5Label: UILabel!
    @IBOutlet weak var product7Label: UILabel!
    @IBOutlet weak var product8Label: UILabel!
    @IBOutlet weak var product9Label: UILabel!
    @IBOutlet weak var product10Label: UILabel!
    @IBOutlet weak var product11Label: UILabel!
    @IBOutlet weak var product12Label: UILabel!
    @IBOutlet weak var product13Label: UILabel!
    @IBOutlet weak var product14Label: UILabel!
    @IBOutlet weak var product15Label: UILabel!
    @IBOutlet weak var product16Label: UILabel!
    @IBOutlet weak var product17Label: UILabel!
    @IBOutlet weak var product18Label: UILabel!
    @IBOutlet weak var product19Label: UILabel!
    @IBOutlet weak var product6Label: UILabel!

    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    @IBOutlet weak var price4Label: UILabel!
    @IBOutlet weak var price5Label: UILabel!
    @IBOutlet weak var price6Label: UILabel!

    @IBOutlet weak var price7Label: UILabel!
    @IBOutlet weak var price8Label: UILabel!
    @IBOutlet weak var price9Label: UILabel!
    @IBOutlet weak var price10Label: UILabel!
    @IBOutlet weak var price11Label: UILabel!
    @IBOutlet weak var price12Label: UILabel!
    @IBOutlet weak var price13Label: UILabel!
    @IBOutlet weak var price14Label: UILabel!
    @IBOutlet weak var price15Label: UILabel!
    @IBOutlet weak var price16Label: UILabel!
    @IBOutlet weak var price17Label: UILabel!
    @IBOutlet weak var price18Label: UILabel!
    @IBOutlet weak var price19Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in groceriesData.indices  {
            print("\(i): \(groceriesData[i])")
        }
        
        product1Label.text = groceriesData[0].0
        product2Label.text = groceriesData[1].0
        product3Label.text = groceriesData[2].0
        product4Label.text = groceriesData[3].0
        product5Label.text = groceriesData[4].0
        product6Label.text = groceriesData[5].0
        product7Label.text = groceriesData[6].0
        product8Label.text = groceriesData[7].0
        product9Label.text = groceriesData[8].0
        product10Label.text = groceriesData[9].0
        product11Label.text = groceriesData[10].0
        product12Label.text = groceriesData[11].0
        product13Label.text = groceriesData[12].0
        product14Label.text = groceriesData[13].0
        product15Label.text = groceriesData[14].0
        product16Label.text = groceriesData[15].0
        product17Label.text = groceriesData[16].0
        product18Label.text = groceriesData[17].0
        product19Label.text = groceriesData[18].0
        
        
        price1Label.text = groceriesData[0].1
        price2Label.text = groceriesData[1].1
        price3Label.text = groceriesData[2].1
        price4Label.text = groceriesData[3].1
        price5Label.text = groceriesData[4].1
        price6Label.text = groceriesData[5].1
        price7Label.text = groceriesData[6].1
        price8Label.text = groceriesData[7].1
        price9Label.text = groceriesData[8].1
        price10Label.text = groceriesData[9].1
        price11Label.text = groceriesData[10].1
        price12Label.text = groceriesData[11].1
        price13Label.text = groceriesData[12].1
        price14Label.text = groceriesData[13].1
        price15Label.text = groceriesData[14].1
        price16Label.text = groceriesData[15].1
        price17Label.text = groceriesData[16].1
        price18Label.text = groceriesData[17].1
        price19Label.text = groceriesData[18].1
    }
    
}
