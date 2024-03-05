//
//  BaseViewController.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 2.03.2024.
//

import UIKit
import FirebaseAnalytics

class BaseViewController: UIViewController, ViewModelDelegate {
    var data: ViewModelData?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.logEvent(AnalyticsEventScreenView, parameters: nil)
    }
    
    func showAlert(alert: Alert) {
        let model = alert.model
        let alert = UIAlertController(title: model.title, message: model.detail, preferredStyle: .alert)
        if model.actions.isEmpty {
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
        } else {
            for i in model.actions {
                let action = UIAlertAction(title: i.0, style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.alertButtonPressed(action: i.1)
                }
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true)
    }
    
    func alertButtonPressed(action: AlertActions) {
        // Intentionally Unimplemented
    }
}
