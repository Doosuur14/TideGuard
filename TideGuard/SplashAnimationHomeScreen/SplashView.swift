//
//  SplashView.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 05.04.2025.
//

import UIKit

class SplashView: UIView {
    private lazy var mapImageView: UIImageView = UIImageView()
    private lazy var appName: UILabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFunc()
        startAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpFunc() {
        setupAppName()
        setupMap()
    }

    private func startAnimation() {
        animateRipple()
        animateMapZoom()
        animateAppName()
    }


    private func setupAppName() {
        addSubview(appName)
        appName.text = "TideGuard"
        appName.font = .systemFont(ofSize: 36, weight: .bold)
        appName.textColor = UIColor(named: "MainColor")
        appName.textAlignment = .center
        appName.alpha = 0
        appName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-self.bounds.height * 0.20)
            make.height.equalTo(50)
        }
    }
    private func setupMap() {
        addSubview(mapImageView)
        mapImageView.image =  UIImage(named: "map")
        mapImageView.contentMode = .scaleAspectFit
        mapImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        mapImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func animateRipple() {
        let rippleLayer = CAShapeLayer()
        let center = self.center
        let startRadius: CGFloat = 20
        let endRadius: CGFloat = max(self.bounds.width, self.bounds.height)

        rippleLayer.path = UIBezierPath(ovalIn: CGRect(x: center.x - startRadius, y: center.y - startRadius, width: startRadius * 2, height: startRadius * 2)).cgPath
        rippleLayer.fillColor = UIColor.blue.withAlphaComponent(0.3).cgColor
        self.layer.addSublayer(rippleLayer)

        let scaleAnimation = CABasicAnimation(keyPath: "path")
        scaleAnimation.toValue = UIBezierPath(ovalIn: CGRect(x: center.x - endRadius, y: center.y - endRadius, width: endRadius * 2, height: endRadius * 2)).cgPath

        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.toValue = 0

        let group = CAAnimationGroup()
        group.animations = [scaleAnimation, fadeAnimation]
        group.duration = 5.0
        group.repeatCount = 5
        rippleLayer.add(group, forKey: "ripple")
    }

    func animateMapZoom() {
        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.mapImageView.transform = .identity
        })
    }

    func animateAppName() {
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseIn, animations: {
            self.appName.alpha = 1
            self.appName.transform = CGAffineTransform(translationX: 0, y: -10)
        })
    }

}
