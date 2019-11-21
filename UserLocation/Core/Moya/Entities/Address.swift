//
//  Address.swift
//  UserLocation
//
//  Created by Igor Karyi on 21.11.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import ObjectMapper

struct Address {
    var houseNumber     : String?
    var road            : String?
    var neighbourhood   : String?
    var suburb          : String?
    var county          : String?
    var city            : String?
    var postcode        : String?
    var country         : String?
    var countryCode     : String?
}

extension Address: Mappable {
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        houseNumber     <- map["house_number"]
        road            <- map["road"]
        neighbourhood   <- map["neighbourhood"]
        suburb          <- map["suburb"]
        county          <- map["county"]
        city            <- map["city"]
        postcode        <- map["postcode"]
        country         <- map["country"]
        countryCode     <- map["country_code"]
    }
    
}
