//
//  BaseViewModel.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 2.03.2024.
//

import Foundation

protocol ViewModelData {
}

class BaseViewModel {
    let delegate: ViewModelDelegate
    
    init(_ delegate: ViewModelDelegate) {
        self.delegate = delegate
    }
    
    func handleFailure(error: Error) {
        delegate.showAlert(alert: Alert.error(error))
    }
}

protocol ViewModelDelegate {
    func showAlert(alert: Alert)
    func alertButtonPressed(action: AlertActions)
}
