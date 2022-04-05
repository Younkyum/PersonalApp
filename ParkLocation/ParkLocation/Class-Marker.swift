//
//  Class-Marker.swift
//  ParkLocation
//
//  Created by Jin younkyum on 2022/04/04.
//

import MapKit

class Marker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let subtitle: String?
    
    init(
        title: String?,
        subtitle: String?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        
        super.init()
    }
    
}
