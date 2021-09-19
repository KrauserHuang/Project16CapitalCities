//
//  Capital.swift
//  Project16CapitalCities
//
//  Created by Tai Chin Huang on 2021/9/17.
//

import UIKit
import MapKit
// you can only subclass NSObject, since Map Annotations(MKAnnotation) is a protocol not a class
class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }

}
