//
//  SafetyViewController.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 17.04.2025.
//

import UIKit
import MapKit

class SafetyViewController: UIViewController, MKMapViewDelegate {

    var safetyView: SafetyView?
    let viewModel: SafetyViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFunc()
        configureIO()
        viewModel.loadMap()
        viewModel.loadEvacuationData()
        viewModel.fetchWeather()
    }

    init(viewModel: SafetyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpFunc() {
        safetyView = SafetyView(frame: view.bounds)
        view  = safetyView
        view.backgroundColor = .systemBackground
        safetyView?.mapView.delegate = self
    }

    private func configureIO() {
        print("calling evacuation")
        viewModel.onEvacuationUpdate = { [weak self] text in
            self?.safetyView?.evacuationLabel.text = text
            print("success")
        }
        viewModel.onMapUpdate = { [weak self] center in
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 50000, longitudinalMeters: 50000)
            self?.safetyView?.mapView.setRegion(region, animated: true)
        }
        viewModel.onFloodAreasUpdate = { [weak self] floodAreas in
            guard let mapView = self?.safetyView?.mapView else { return }
            mapView.addOverlays(floodAreas)
//            guard let mapView = self?.safetyView?.mapView else { return }
//            floodAreas.forEach { mapView.addOverlay($0) }
        }
        viewModel.onWeatherUpdate = { [weak self] description, temperature, humidity, imageURL in
            print("Updating weather UI - Description: \(description), Temp: \(temperature), Humidity: \(humidity), Image: \(imageURL ?? "None")")
            self?.safetyView?.weatherDescriptionLabel.text = "Weather: \(description)"
            self?.safetyView?.temperatureLabel.text = "Temp: \(String(format: "%.1f", temperature))°C"
            self?.safetyView?.humidityLabel.text = "Humidity: \(String(format: "%.0f", humidity))%"
            self?.safetyView?.updateWeatherImage(with: imageURL)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 2
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
