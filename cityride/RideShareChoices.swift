//
//  RideShareChoices.swift
//  cityride
//
//  Created by Matthew Attou on 5/21/16.
//  Copyright © 2016 Matthew Attou. All rights reserved.
//

import UIKit
import CoreLocation
import Polyline
import Alamofire
import SwiftyJSON
import GoogleMaps

class RideShareChoices: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var array = Array<TableCellModel>()
    var halfwayCord = CLLocationCoordinate2D()
    var destintion = String()
    
    let data1 = TableCellModel(name: "WALK", price: "Free", distance: "30 mins", imageType: "walk")
    let data2 = TableCellModel(name: "BIKE", price: "Free", distance: "20 mins", imageType: "bike")
    let data3 = TableCellModel(name: "BUS", price: "$2.00", distance: "45 mins", imageType: "bus")
    let data4 = TableCellModel(name: "TROLLEY", price: "$5.00", distance: "15 mins", imageType: "trolley")
    let data5 = TableCellModel(name: "UBER", price: "$7.00", distance: "10 mins", imageType: "car")
    let data6 = TableCellModel(name: "LYFT", price: "$8.00", distance: "9 mins", imageType: "car")
    
    let tdParams = [
        
        "data": ["query": "INSERT INTO hack06.userData (location, transportationMode, id) VALUES(mobile, car, 12345)",]
        
        ]
    
    let path = GMSMutablePath()

    @IBOutlet weak var optionsLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        array.append(data1)
        array.append(data2)
        array.append(data3)
        array.append(data4)
        array.append(data5)
        array.append(data6)
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.registerNib(UINib(nibName: "OptionsCell", bundle: nil), forCellReuseIdentifier: "optionscell")
        
        self.getPolyline()
    }
    
    func getPolyline() {
        
        let networkOperations = BaseNetworkClass()
        
        var arrayModel:Array<DataModel> = []
        
        let directionParams = [
            
            "origin":"10111 N torrey pines rd la jolla ca",
            "destination":self.destintion,
            "key":"AIzaSyC0akZwTfZD_O0A235baSUx1YlfPOtlEyU",
            
            ]
        
        networkOperations.getRequest("https://maps.googleapis.com/maps/api/directions/json", parameters: directionParams) {
            
            (result: AnyObject) in
                
                if let routes = result["routes"] as? [[String: AnyObject]] { //array of dictionaries [bounds:data], [overview_polyline:data]
                    
                    for overview_polyline in routes { // array of routes
                        
                        let poly = overview_polyline["overview_polyline"]
                        
                        if(poly != nil){
                            
                            if let polylineString = poly!["points"] as? String {
                                
                                let cords:Array<CLLocationCoordinate2D> = self.getLongLatFromPolyLine(polylineString)
                                
                                self.halfwayCord = cords[cords.count/2]
                                
                                for data: CLLocationCoordinate2D in cords {
                                    
                                    let model = DataModel(lat:String(data.latitude), lng:String(data.longitude))
                                    arrayModel.append(model)
                                    
                                    
                                    self.path.addCoordinate(data)
                                    
                                    print(String(data.latitude)+","+String(data.longitude))
                                }
                                
                            }
                        }
                    }
                }
            }
    }
    
    func getLongLatFromPolyLine(polyline: String) ->  Array<CLLocationCoordinate2D> {
        
        let polyline = Polyline(encodedPolyline: polyline)
        let decodedCoordinates: [CLLocationCoordinate2D]? = polyline.coordinates
        
        return decodedCoordinates!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCellWithIdentifier("optionscell", forIndexPath: indexPath) as! OptionsCell
        
        let cellModel = self.array[indexPath.row]
        
        cell.cButton.addTarget(self, action: #selector(RideShareChoices.showAlert), forControlEvents: .TouchUpInside)
        cell.cButton.setTitle(cellModel.name, forState: UIControlState.Normal)
        cell.price.text = cellModel.price
        cell.distance.text = cellModel.distance
        
        let image = UIImage(named:cellModel.imageType)
        
        cell.iconImage!.image = image
        
        return cell
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Request", style: .Default) { (action) in
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let mapsViewController = storyBoard.instantiateViewControllerWithIdentifier("maps") as! MapsViewController
            
            mapsViewController.path = self.path
            mapsViewController.halfwayCord = self.halfwayCord
            
//            let baseNetworkClass = BaseNetworkClass()
            
//            baseNetworkClass.postRequest("http://52.40.72.189:1080/tdrest/systems/hack06connection/queries", parameters: self.tdParams) {
//                
//                (result: AnyObject) in
//                
//                print(result)
//                
//
//            }
            
            self.presentViewController(mapsViewController, animated: false, completion: nil)
            
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.1
    }
}
