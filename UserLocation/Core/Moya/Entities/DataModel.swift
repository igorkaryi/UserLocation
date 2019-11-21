//
//  InfoLocation.swift
//  UserLocation
//
//  Created by Igor Karyi on 21.11.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import ObjectMapper

struct InfoLocation {
    var placeId      : Int?
    var licence      : String?
    var osmType      : String?
    var osmId        : Int?
    var lat          : String?
    var lon          : String?
    var displayName  : String?
    var address      : Address?
    var boundingbox  : [String]?
}

extension InfoLocation: Mappable {
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        placeId      <- map["place_id"]
        licence      <- map["licence"]
        osmType      <- map["osm_type"]
        osmId        <- map["osm_id"]
        lat          <- map["lat"]
        lon          <- map["lon"]
        displayName  <- map["display_name"]
        address      <- map["address"]
        boundingbox  <- map["boundingbox"]
    }
    
}
