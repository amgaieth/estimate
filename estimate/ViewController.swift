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

//class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
class ViewController: UIViewController  {
    @IBOutlet weak var countryTextField: UITextField!

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var productTextField: UITextField!
    
    let categories = ["Restaurants", "Markets", "Transportation", "Utilities (Monthly)", "Sports And Leisure", "Clothing And Shoes", "Rent Per Month", "Buy Apartment Price", "Salaries And Financing"]
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func submitButton(sender: AnyObject) {
        load()
    }
    
    // Gets the information from a specific country
    func load() {
        
        guard let country = countryTextField.text   else    {
            print("country is nil")
            return
        }
        
        let attemptedUrl = NSURL(string: "http:www.numbeo.com/cost-of-living/country_result.jsp?country=\(country)")
                
        if let url = attemptedUrl   {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                
                if let urlContent = data    {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    print(webContent)
                    
                    let lines = webContent?.componentsSeparatedByString("\n")
                    if let actualLines = lines  {
                        print(actualLines.count)
                    }
                    else    {
                        print("could not read the lines")
                    }
                    
                    let filtered = lines!.filter {   $0.containsString("<tr><td>")   }
                    
                    guard let product = self.productTextField.text     else    {
                        print("product is nil")
                        return
                    }
                    let productAndPriceArray = filtered.filter   {   $0.containsString(product)  }
                    let productAndPrice = productAndPriceArray[0]
                    
                    
                    
                    let splitProductAndPrice = productAndPrice.componentsSeparatedByString("</td> <td style=\"text-align: right\" class=\"priceValue \"> ")
                    
                    let actualNameOfProduct = splitProductAndPrice[0].stringByReplacingOccurrencesOfString("<tr><td>", withString: "")
                    let actualPriceOfProduct = splitProductAndPrice[1].stringByReplacingOccurrencesOfString("&nbsp;&#8364;</td>", withString: " currency")
                    
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.infoLabel.text = "\(actualNameOfProduct) costs \(actualPriceOfProduct)"
                    }
 
                }
            }
            task.resume()
        }
    }

    @IBAction func autocompleteClicked(sender: AnyObject) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.presentViewController(autocompleteController, animated: true, completion: nil)
    }
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(viewController: GMSAutocompleteViewController, didAutocompleteWithPlace place: GMSPlace) {
        print("Place name: ", place.name)
        print("Place address: ", place.formattedAddress)
        print("Place attributions: ", place.attributions)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func viewController(viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: NSError) {
        // TODO: handle the error.
        print("Error: ", error.description)
    }
    
    // User canceled the operation.
    func wasCancelled(viewController: GMSAutocompleteViewController)    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(viewController: GMSAutocompleteViewController)   {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(viewController: GMSAutocompleteViewController)    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
}

