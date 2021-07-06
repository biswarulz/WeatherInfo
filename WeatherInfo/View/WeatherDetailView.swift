//
//  WeatherDetailView.swift
//  WeatherInfo
//
//  Created by Biswajyoti Sahu on 06/07/21.
//

import UIKit
import MapKit

class WeatherDetailView: UIView {
    
    private let mapView: MKMapView
    private let detailView: UIView
    private let locationNameLabel: UILabel
    private let temperatureLabel: UILabel
    private let locationManger: CLLocationManager
    
    override init(frame: CGRect) {
        
        mapView = MKMapView()
        
        detailView = UIView()
        
        locationNameLabel = UILabel()
        locationNameLabel.textAlignment = .center
        locationNameLabel.font = UIFont.systemFont(ofSize: 28.0, weight: .bold)
        
        temperatureLabel = UILabel()
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont.systemFont(ofSize: 75.0, weight: .bold)
        
        locationManger = CLLocationManager()
        
        super.init(frame: frame)
        
        mapView.delegate = self
        locationManger.delegate = self
        
        detailView.addSubViewsForAutoLayout([locationNameLabel, temperatureLabel])
        addSubViewsForAutoLayout([mapView, detailView])
        addCustomConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillData(_ data: WeatherDetailViewData) {
        
        switch data.weatherType {
        case .cloudy:
            detailView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case .rainy:
            detailView.backgroundColor = #colorLiteral(red: 0.04023883247, green: 0.4856116665, blue: 0.6567600135, alpha: 1)
        case .clear:
            detailView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case .none:
            detailView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        }
        locationNameLabel.text = data.locationName
        temperatureLabel.text = "\(data.temperature) ℃"
        locationNameLabel.textColor = .black
        temperatureLabel.textColor = .black
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(data.coordinates.latitude), longitude: CLLocationDegrees(data.coordinates.longitude))
        annotation.title = data.locationName
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(data.coordinates.latitude), longitude: CLLocationDegrees(data.coordinates.longitude)), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)

    }
    
    private func addCustomConstraints() {
        
        NSLayoutConstraint.activate([
            
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            detailView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            locationNameLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20.0),
            locationNameLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10.0),
            locationNameLabel.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 10.0),
            locationNameLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            temperatureLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 10.0),
            temperatureLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 10.0),
            temperatureLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -10.0),
            temperatureLabel.bottomAnchor.constraint(equalTo: detailView.bottomAnchor, constant: -10.0)
        ])
    }
}

extension WeatherDetailView: MKMapViewDelegate {
    
}

extension WeatherDetailView: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        
        case .notDetermined:
            
            manager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}
