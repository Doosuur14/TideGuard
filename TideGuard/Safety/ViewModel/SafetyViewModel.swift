//
//  SafetyViewModel.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 17.04.2025.
//

import Foundation
import CoreLocation
import MapKit


class SafetyViewModel {

    private var evacuationData: String?
    private var shelters: [String] = []
    private var routes: [String] = []

    var onEvacuationUpdate: ((String) -> Void)?
    var onMapUpdate: ((CLLocationCoordinate2D) -> Void)?
    var onFloodAreasUpdate: (([MKPolygon]) -> Void)?


    func loadEvacuationData() {
        print("gooooooo")
        if let cached = UserDefaults.standard.string(forKey: "evacuationData") {
            evacuationData = cached
            onEvacuationUpdate?(cached)
        } else {
            WeatherService.shared.fetchEvacuationData { [weak self] result in
                switch result {
                case .success(let evacuation):
                    let displayText = "Shelters in \(evacuation.city):\n\(evacuation.shelters)\nRoute:\n\(evacuation.routes)"
                    self?.evacuationData = displayText
                    UserDefaults.standard.set(displayText, forKey: "evacuationData")
                    self?.onEvacuationUpdate?(displayText)
                case .failure(let error):
                    self?.onEvacuationUpdate?("Failed to load evacuation data: \(error.localizedDescription)")
                }
            }
        }
    }


    func loadMap() {
        let user = AuthService.shared.getCurrentUser()
        let userCity = user?.city
        print("User Details: \(String(describing: user))")
        print("User city: \(String(describing: userCity))")


        WeatherService.shared.fetchFloodAreas(for: userCity ?? "") { [weak self] result in
            switch result {
            case .success(let floodArea):
                let floodAreas = floodArea.floodAreas?.compactMap { zone -> MKPolygon? in
                    guard let coords = zone.coordinates, !coords.isEmpty else { return nil }
                    let coordinates = coords.compactMap { coord -> CLLocationCoordinate2D? in
                        guard let lat = coord.latitude, let lon = coord.longitude else { return nil }
                        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    }
                    print("Coordinates for polygon: \(coordinates)")
                    return MKPolygon(coordinates: coordinates, count: coordinates.count)
                } ?? []
                self?.onFloodAreasUpdate?(floodAreas)
            case .failure(let error):
                print("Failed to fetch flood areas: \(error)")
                self?.onFloodAreasUpdate?([])
            }
        }


        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(userCity ?? "") { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                let fallbackCenter = CLLocationCoordinate2D(latitude: 9.0820, longitude: 8.6753)
                self?.onMapUpdate?(fallbackCenter)
                return
            }
            if let placemark = placemarks?.first, let location = placemark.location {
                let center = location.coordinate
                print("Geocoded coordinates for \(String(describing: userCity)): \(center)")
                self?.onMapUpdate?(center)
            } else {
                print("No coordinates found for \(String(describing: userCity))")
                let fallbackCenter = CLLocationCoordinate2D(latitude: 9.0820, longitude: 8.6753)
                self?.onMapUpdate?(fallbackCenter)
            }
        }
    }

}
