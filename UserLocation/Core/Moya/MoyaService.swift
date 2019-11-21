//
//  MoyaService.swift
//  UserLocation
//
//  Created by Igor Karyi on 21.11.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Moya
import MapKit

enum MoyaService {
    case infoLocationWithCoordinate(coordinate: CLLocationCoordinate2D)
}

extension MoyaService: TargetType {
    
    var baseURL: URL { return URL(string: "https://nominatim.openstreetmap.org")! }
    
    var path: String {
        switch self {
        case .infoLocationWithCoordinate: return "/reverse.php"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .infoLocationWithCoordinate: return .get
        }
    }
    
    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .infoLocationWithCoordinate(let coordinate):
            return [
                "format": "json",
                "lat": coordinate.latitude,
                "lon": coordinate.longitude
            ]
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

}

