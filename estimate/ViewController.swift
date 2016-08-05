//
//  ViewController.swift
//  estimate
//
//  Created by Anouar Mgaieth on 7/14/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit
import Foundation
//import SwiftyJSON
import GoogleMaps

class ViewController: UIViewController  {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let subView = UIView(frame: CGRectMake(0, 65.0, 350.0, 45.0))
        
        subView.addSubview((searchController?.searchBar)!)
        self.view.addSubview(subView)
        
        
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        self.definesPresentationContext = true
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func load(country1: String, city1: String) {
        
        let attemptedUrl = NSURL(string: "http://www.numbeo.com/cost-of-living/city_result.jsp?country=\(country1)&city=\(city1)")
        
        if let url = attemptedUrl   {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data    {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let lines = webContent?.componentsSeparatedByString("\n")
                    
                    var filteredArray = lines!.filter {   $0.containsString("<tr><td")   }
                    
                    var filteredArrayOfProducts = [String]()
                    
                    for i in filteredArray.indices  {
                        if filteredArray[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">") != nil || filteredArray[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">") != nil {
                            filteredArrayOfProducts.append(filteredArray[i])
                        }
                    }
                    
                    var productAndPrice: String
                    var productAndPriceArray = [String]()
                    
                    for i in filteredArrayOfProducts.indices {
                        if filteredArrayOfProducts[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">") != nil  {
                            // remove "</td> <td style=\"text-align: right\" class=\"priceValue \">"
                            productAndPrice = filteredArrayOfProducts[i].stringByReplacingOccurrencesOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">", withString: "")
                            // remove <tr><td>
                            productAndPrice = productAndPrice.stringByReplacingOccurrencesOfString("<tr><td>", withString: "")
                            // remove the code for currency
                            productAndPriceArray.append(productAndPrice)
                        }
                        else if filteredArrayOfProducts[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">") != nil   {
                            productAndPrice = filteredArrayOfProducts[i].stringByReplacingOccurrencesOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">", withString: "")
                            productAndPrice = productAndPrice.stringByReplacingOccurrencesOfString("<tr><td class=\"tr_highlighted\">", withString: "")
                            productAndPriceArray.append(productAndPrice)
                        }
                    }
                    
                    var product: String
                    var price: String
                    // array that has two elements; the product and the price
                    var prodAndpriceArray = [String]()
                    var dict = [String: String]()
                    
                    for i in productAndPriceArray.indices   {
                        prodAndpriceArray = productAndPriceArray[i].componentsSeparatedByString("  ")
                        product = prodAndpriceArray[0]
                        price = prodAndpriceArray[1]
                        dict[product] = price
                        print("\(product): \(price)")
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                    }
                }
            }
            task.resume()

        }
        
    }
    
    func load(country1: String, city1: String, state1: String) {

        let attemptedUrl = NSURL(string: "http://www.numbeo.com/cost-of-living/city_result.jsp?country=United+States&city=\(city1)%2C+\(state1)")
        
        if let url = attemptedUrl   {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data    {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let lines = webContent?.componentsSeparatedByString("\n")
                    
                    var filteredArray = lines!.filter {   $0.containsString("<tr><td")   }

                    var filteredArrayOfProducts = [String]()
                    
                    for i in filteredArray.indices  {
                        if filteredArray[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">") != nil || filteredArray[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">") != nil {
                            filteredArrayOfProducts.append(filteredArray[i])
                        }
                    }

                    var productAndPrice: String
                    var productAndPriceArray = [String]()
                    
                    for i in filteredArrayOfProducts.indices {
                        if filteredArrayOfProducts[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">") != nil  {
                            // remove "</td> <td style=\"text-align: right\" class=\"priceValue \">"
                            productAndPrice = filteredArrayOfProducts[i].stringByReplacingOccurrencesOfString("</td> <td style=\"text-align: right\" class=\"priceValue \">", withString: "")
                            // remove <tr><td>
                            productAndPrice = productAndPrice.stringByReplacingOccurrencesOfString("<tr><td>", withString: "")
                            productAndPriceArray.append(productAndPrice)
                        }
                        else if filteredArrayOfProducts[i].rangeOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">") != nil   {
                            productAndPrice = filteredArrayOfProducts[i].stringByReplacingOccurrencesOfString("</td> <td style=\"text-align: right\" class=\"priceValue tr_highlighted\">", withString: "")
                            productAndPrice = productAndPrice.stringByReplacingOccurrencesOfString("<tr><td class=\"tr_highlighted\">", withString: "")
                            productAndPriceArray.append(productAndPrice)
                        }
                    }

                    var product: String
                    var price: String
                    // array that has two elements; the product and the price
                    var prodAndpriceArray = [String]()
                    var dict = [String: String]()
                    
                    for i in productAndPriceArray.indices   {
                        prodAndpriceArray = productAndPriceArray[i].componentsSeparatedByString("  ")
                        product = prodAndpriceArray[0]
                        price = prodAndpriceArray[1]
                        dict[product] = price
                        print("\(product): \(price)")
                    }
                
                    dispatch_async(dispatch_get_main_queue()) {
                    }
                }
            }
            task.resume()
        }
    }
}

// Handle the user's selection.
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController, didAutocompleteWithPlace place: GMSPlace) {
        searchController?.active = false
        
        // separate the formattedAddress into city, state, country
        let seperatedformattedAddress =  place.formattedAddress!.componentsSeparatedByString(", ")
        print(place.placeID)
        // countries that use a state
        if seperatedformattedAddress.count == 3 {
            if seperatedformattedAddress[2] == "USA"    {
                let first = seperatedformattedAddress[0]        // city
                let second = seperatedformattedAddress[1]       // state
                let third = seperatedformattedAddress[2]        // country
                // if input includes a space
                if first.containsString(" ") || second.containsString(" ") || third.containsString(" ") {
                    let city =  first.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let state = second.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let country = third.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    load(country, city1: city, state1: state)
                }
                else    {
                    let city = first
                    let state = second
                    let country = third
                    load(country, city1: city, state1: state)
                }
            }
            // numbeo does not show state names for other countries
            else    {
                let first = seperatedformattedAddress[0]        // city
                let third = seperatedformattedAddress[2]        // country
                
                // if input includes a space
                if first.containsString(" ") || third.containsString(" ") {
                    let city =  first.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let country = third.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    load(country, city1: city)
                }
                else    {
                    let city = first
                    let country = third
                    load(country, city1: city)
                }
            }
        }
        else if seperatedformattedAddress.count == 2 {
            let city = seperatedformattedAddress[0]
            let country = seperatedformattedAddress[1]
            
            load(country, city1: city)
        }
        else    {
            print("fix this")
        }
    }
    
//    func resultsController(resultsController: GMSAutocompleteResultsViewController, didSelectPrediction prediction: GMSAutocompletePrediction) -> Bool  {
//        //performSegueWithIdentifier("viewControllerToTableView", sender: self)
//        let controller = storyboard?.instantiateViewControllerWithIdentifier("DashboardViewController")
//        self.presentViewController(controller!, animated: true, completion: nil)
//        return true
//        }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: NSError){
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsForResultsController(resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

