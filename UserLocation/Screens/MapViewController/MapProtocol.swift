//
//  MapProtocol.swift
//  UserLocation
//
//  Created by Igor Karyi on 21.11.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import RxSwift
import MapKit

protocol MapProtocol: class {
    
    func getInfoLocationWithCoordinate(_ coordinate: CLLocationCoordinate2D, completion: @escaping ((InfoLocation) -> Void))
    var errorString: Variable<String> { get }
    
}
