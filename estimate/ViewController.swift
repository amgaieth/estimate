//
//  ViewController.swift
//  estimate
//
//  Created by Anouar Mgaieth on 7/14/16.
//  Copyright © 2016 Anouar Mgaieth. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import GoogleMaps


class ViewController: UIViewController  {
    
    var priceAndProduct = [(String, String)]()
    
    var first = String()
    
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
        
        let subView = UIView(frame: CGRectMake(0, 333.5, 375.0, 45.0))
        
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
                    
                    var x = [String]()
                    var y = [String]()
                    
                    for i in lines!.indices {
                        if lines![i].containsString("<option value")    {
                            x.append(lines![i])
                        }
                    }
                    
                    for i in x.indices  {
                        if x[i].containsString("selected=\"selected\">")    {
                            y.append(x[i])
                        }
                        
                    }
                    
                    
                    let currencyArr = y[1].componentsSeparatedByString(" selected=\"selected\">")
                    
                    let currency = currencyArr[1].stringByReplacingOccurrencesOfString("</option>", withString: "")
                    
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
                    
                    for i in productAndPriceArray.indices   {
                        prodAndpriceArray = productAndPriceArray[i].componentsSeparatedByString("  ")
                        product = prodAndpriceArray[0]
                        price = prodAndpriceArray[1]
                        let priceArray = price.componentsSeparatedByString("&")
                        price = priceArray[0] + " " + currency
                        self.priceAndProduct.append((product, price))

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
                    
                    var x = [String]()
                    var y = [String]()
                    
                    for i in lines!.indices {
                        if lines![i].containsString("<option value")    {
                            x.append(lines![i])
                        }
                    }
                    
                    for i in x.indices  {
                        if x[i].containsString("selected=\"selected\">")    {
                            y.append(x[i])
                        }
                    
                    }
                    
                    let currencyArr = y[1].componentsSeparatedByString(" selected=\"selected\">")
                    
                    let currency = currencyArr[1].stringByReplacingOccurrencesOfString("</option>", withString: "")
                    
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
                    
                    for i in productAndPriceArray.indices   {
                        prodAndpriceArray = productAndPriceArray[i].componentsSeparatedByString("  ")
                        product = prodAndpriceArray[0]
                        price = prodAndpriceArray[1]
                        let priceArray = price.componentsSeparatedByString("&")
                        price = priceArray[0] + " " + currency
                        self.priceAndProduct.append((product, price))
                    }
                    dispatch_async(dispatch_get_main_queue()) {
                    }
                    
                    
                }
            }
            task.resume()
        }
    }
    
    func getWeather(urlString: String)   {
        
        let url = NSURL(string: "http://" + urlString)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)   { (data, response, error) in
            dispatch_async(dispatch_get_main_queue(),   {
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    self.setLabels(data)
                }
            })
        }
        task.resume()
    }
    
    var temperature = String()
    var descript = String()
    
    func setLabels(weatherData: NSData) {
        
        do  {
           let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options: .AllowFragments) as? NSDictionary
            
            if let name = json!["name"] as? String   {
                first = name
            }
            
            if let main = json!["main"] as? NSDictionary {
                if var temp = main["temp"] as? Double   {
                    temp = temp - 273.15
                    temp = (temp * 9.0)/5.0 + 32
                    temperature = String(format: "%.1f", temp)
                    temperature = temperature + "ºF"
                }
            }
            
            if let weather = json!["weather"] as? NSArray  {
                if let description = weather[0]["description"] as? String   {
                    descript = description
                }
            }
        }
        catch (let error as NSError)   {
            print(error.localizedDescription)
        }
    }
    
    func getTime()  {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toDashboard"    {
            let dashboardViewController = segue.destinationViewController as! DashboardViewController
            dashboardViewController.priceAndProduct = priceAndProduct
            dashboardViewController.city = first
            dashboardViewController.temperature = temperature
            dashboardViewController.descript = descript
            print(NSDate())
        }
    }
}

// Handle the user's selection.
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(resultsController: GMSAutocompleteResultsViewController, didAutocompleteWithPlace place: GMSPlace) {
        searchController?.active = false
        
        // separate the formattedAddress into city, state, country
        let seperatedformattedAddress =  place.formattedAddress!.componentsSeparatedByString(", ")
        // countries that use a state
        if seperatedformattedAddress.count == 3 {
            if seperatedformattedAddress[2] == "USA"    {
                first = seperatedformattedAddress[0]        // city
                let second = seperatedformattedAddress[1]       // state
                let third = seperatedformattedAddress[2]        // country
                // if input includes a space
                if first.containsString(" ") || second.containsString(" ") || third.containsString(" ") {
                    let city =  first.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let state = second.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    let country = third.stringByReplacingOccurrencesOfString(" ", withString: "+")
                    load(country, city1: city, state1: state)
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")

                }
                else    {
                    let city = first
                    let state = second
                    let country = third
                    load(country, city1: city, state1: state)
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")

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
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
                }
                else    {
                    let city = first
                    let country = third
                    load(country, city1: city)
                    getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
                }
            }
        }
        else if seperatedformattedAddress.count == 2 {
            let city = seperatedformattedAddress[0]
            let country = seperatedformattedAddress[1]
            
            load(country, city1: city)
            getWeather("api.openweathermap.org/data/2.5/weather?q=\(city)&id=524901&APPID=581c938a5549bc5efafc393d7f18af9b")
        }
        else    {
            print("fix this")
        }
        
    }
    
    
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

