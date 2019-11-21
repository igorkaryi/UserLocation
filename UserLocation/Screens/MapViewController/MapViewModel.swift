//
//  MapViewModel.swift
//  UserLocation
//
//  Created by Igor Karyi on 21.11.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Moya
import Moya_ObjectMapper
import RxSwift
import MapKit

class MapViewModel: MapProtocol {
    
    private let service = MoyaProvider<MoyaService>()
    
    var errorString = Variable<String>("")
    
    func getInfoLocationWithCoordinate(_ coordinate: CLLocationCoordinate2D, completion: @escaping ((InfoLocation) -> Void)) {
        service.request(.infoLocationWithCoordinate(coordinate: coordinate)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let data = try? response.mapObject(InfoLocation.self) else { return }
                completion(data)
            case .failure(let error):
                self?.errorString.value = error.errorDescription ?? "unknown error"
            }
        }
    }

}
