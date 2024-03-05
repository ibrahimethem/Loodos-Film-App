//
//  SplashViewModel.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 3.03.2024.
//

import Foundation
import Network
import FirebaseRemoteConfig

class SplashViewModel: BaseViewModel {
    private let monitor = NWPathMonitor()
    
    func checkNetwork() {
        monitor.start(queue: DispatchQueue.global(qos: .background))
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                guard let delegate = self?.delegate as? SplashViewModelDelegate else { return }
                delegate.hasInternetConnection()
                self?.monitor.cancel()
            } else {
                self?.delegate.showAlert(alert: .noNetwork)
            }
        }
    }
    
    func getTitle() {
        guard let delegate = delegate as? SplashViewModelDelegate else { return }
        let remoteConfig = RemoteConfig.remoteConfig()
        delegate.updateTitle(title: remoteConfig["SplashTitle"].stringValue)
    }
}

protocol SplashViewModelDelegate: ViewModelDelegate {
    func hasInternetConnection()
    func updateTitle(title: String?)
}
