//
//  SafetyView.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 17.04.2025.
//

import UIKit
import MapKit

class SafetyView: UIView {
    lazy var segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Map", "Evacuation", "Weather"])
    lazy var containerView: UIView = UIView()
    lazy var mapView: MKMapView = MKMapView()
    lazy var evacuationLabel: UILabel = UILabel()
    lazy var weatherLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFunc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupFunc() {
        setUpSegments()
        setUpContainer()
        setUpMap()
        setUpEvacuationLabel()
        setUpWeatherLabel()

    }

    private func setUpSegments() {
        addSubview(segmentedControl)
       // segmentedControl.tintColor = UIColor(named: "MainColor")
        segmentedControl.backgroundColor = UIColor(named: "BackgroundColor")
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(named: "MainColor") as Any], for: .selected)
        segmentedControl.addTarget(self, action: #selector(switchSection), for: .valueChanged)
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func setUpContainer() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

    private func setUpMap() {
        containerView.addSubview(mapView)
        mapView.isHidden = false
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }

    private func setUpEvacuationLabel() {
        containerView.addSubview(evacuationLabel)
        evacuationLabel.font = .systemFont(ofSize: 15, weight: .bold)
        evacuationLabel.textColor = UIColor(named: "mainColor")
        evacuationLabel.numberOfLines = 0
        evacuationLabel.isHidden = true
        evacuationLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.bottom.lessThanOrEqualTo(containerView.snp.bottom).inset(16)
        }
    }

    private func setUpWeatherLabel() {
        containerView.addSubview(weatherLabel)
        weatherLabel.numberOfLines = 0
        weatherLabel.isHidden = true
        weatherLabel.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }

    @objc private func switchSection(_ sender: UISegmentedControl) {
        mapView.isHidden = true
        evacuationLabel.isHidden = true
        weatherLabel.isHidden = true

        switch sender.selectedSegmentIndex {
        case 0: mapView.isHidden = false
        case 1: evacuationLabel.isHidden = false
        case 2: weatherLabel.isHidden = false
        default: break
        }
    }
}
