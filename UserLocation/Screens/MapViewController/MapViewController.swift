//
//  MapViewController.swift
//  UserLocation
//
//  Created by Igor Karyi on 21.11.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class MapViewController: UIViewController {
    
    @IBOutlet fileprivate weak var mapView: MKMapView!
    @IBOutlet fileprivate weak var infoView: UIView!
    @IBOutlet fileprivate weak var addressLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private var timer = Timer()
    
    private var disposeBag = DisposeBag()
    private var viewModel: MapProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        viewModel = MapViewModel()
        setupInfoView()
        getUserLocation()
    }
    
    private func setupInfoView() {
        infoView.layer.borderColor = #colorLiteral(red: 0.5176677108, green: 0.1954577863, blue: 0.3542500138, alpha: 1)
        infoView.layer.borderWidth = 1
    }

}

extension MapViewController {
    
    private func getInfoLocationWithCoordinate(coordinate: CLLocationCoordinate2D) {
        viewModel?.getInfoLocationWithCoordinate(coordinate, completion: { [weak self] (info) in
            self?.setInfo(info)
        })

        viewModel?.errorString
            .asObservable()
            .subscribe(onNext: { [weak self] errorStr in
                if (errorStr != "") {
                    print("error")
                }
        }).disposed(by: disposeBag)
    }
    
    private func setInfo(_ info: InfoLocation) {
        title = info.address?.city
        addressLabel.text = formatedAddress(info.address)
    }
    
    private func formatedAddress(_ address: Address?) -> String {
        guard let address = address else { return NSLocalizedString("No address", comment: "") }
        
        let items: [String] = [
            address.country ?? "",
            address.city ?? "",
            address.county ?? "",
            address.road ?? "",
            address.houseNumber ?? ""
        ]
        
        let title = items.joined(separator: ", ")
        
        return title
    }
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    private func getUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        getInfoLocationWithCoordinate(coordinate: locValue)
    }
    
}
