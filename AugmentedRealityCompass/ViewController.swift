//
//  ViewController.swift
//  AugmentedRealityCompass
//
//  Created by Matt Milner on 8/4/16.
//  Copyright © 2016 Matt Milner. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    var imagePicker: UIImagePickerController!
    var locationManager: CLLocationManager!
    var overlayView: UIView!
    var compassArrow: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .Camera
        
        self.compassArrow = UIImageView(image: UIImage(named:"compass-arrow.png"))
        compassArrow.frame = CGRect(x: (self.view.frame.size.width/2)-50 , y: 200, width: 100, height: 100)
        
        let north = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-5, y: 100, width: 20, height: 20))
        north.text = "N"
        north.textColor = UIColor.redColor()
        
        let south = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-5, y: 400, width: 20, height: 20))
        south.text = "S"
        south.textColor = UIColor.redColor()
        
        let west = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-150, y: 240, width: 20, height: 20))
        west.text = "W"
        west.textColor = UIColor.redColor()
        
        let east = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)+150, y: 240, width: 20, height: 20))
        east.text = "E"
        east.textColor = UIColor.redColor()
        
        self.overlayView = UIView(frame: CGRect(x: 0, y: 0, width: (self.view.frame.size.width), height: (self.view.frame.size.height)))
        
        let arrowInfoLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width/2)-150, y: (self.view.frame.size.height) - 250, width: 300, height: 20))
        arrowInfoLabel.text = "Green Arrow Indicates North"
        arrowInfoLabel.textAlignment = NSTextAlignment.Center
        arrowInfoLabel.textColor = UIColor.greenColor()
        
        overlayView.addSubview(compassArrow)
        overlayView.addSubview(north)
        overlayView.addSubview(south)
        overlayView.addSubview(east)
        overlayView.addSubview(west)
        overlayView.addSubview(arrowInfoLabel)
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
    
        self.locationManager.startUpdatingHeading()

        self.imagePicker.cameraOverlayView = overlayView

    
    }

    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {

        let degrees = newHeading.magneticHeading
        let radians = degrees * M_PI / 180
        
        self.compassArrow.transform = CGAffineTransformMakeRotation(CGFloat(-radians))
        
    }
    
    

    
    @IBAction func showCompass() {
        
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
        
        
        
        let currentHeading = locationManager.heading
        
        print(currentHeading)
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

