//
//  SplashViewController.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 3.03.2024.
//

import UIKit
import FirebaseRemoteConfig
import Network

class SplashViewController: BaseViewController, SplashViewModelDelegate {
    var viewModel: SplashViewModel?
    var remoteConfig: RemoteConfig!
    
    @IBOutlet weak var appNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SplashViewModel(self)
        
        viewModel?.getTitle()
        viewModel?.checkNetwork()
    }
    
    override func alertButtonPressed(action: AlertActions) {
        switch action {
        case .tryAgain:
            viewModel?.checkNetwork()
        default:
            super.alertButtonPressed(action: action)
        }
    }
    
    func hasInternetConnection() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            NavigationRouter.shared.setRootViewController(to: ViewPath(storyboard: "Main", view: "Movies"), withNavigationController: true)
        }
    }
    
    func updateTitle(title: String?) {
        self.appNameLabel.text = title
    }
}
