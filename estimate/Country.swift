//
//  Country.swift
//  estimate
//
//  Created by Anouar Mgaieth on 7/22/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Country {
    
    let countryName: String
    let currency: String
    
    init(countryJSON: JSON)    {
        self.countryName = countryJSON["name"].stringValue
        self.currency = countryJSON["currencies"][0].stringValue
    }
    
}