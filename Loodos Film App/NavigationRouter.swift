//
//  NavigationRouter.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 3.03.2024.
//

import Foundation
import UIKit

struct ViewPath {
    let storyboard: String
    let view: String
}

class NavigationRouter {
    static let shared = NavigationRouter()
    
    private var navigationController: UINavigationController?

    private var currentWindow: UIWindow? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }

    func configureNavigationController() {
        self.navigationController = UINavigationController()
        self.currentWindow?.rootViewController = navigationController
        self.currentWindow?.makeKeyAndVisible()
    }

    func push(from: BaseViewController, viewPath: ViewPath, data: ViewModelData? = nil) {
        let storyboard = UIStoryboard(name: viewPath.storyboard, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewPath.view) as? BaseViewController else { return }
        viewController.data = data
        if let nc = from.navigationController {
            nc.pushViewController(viewController, animated: true)
        } else {
            present(from: from, viewPath: viewPath)
        }
    }
    
    func present(from: BaseViewController, viewPath: ViewPath, data: ViewModelData? = nil) {
        let storyboard = UIStoryboard(name: viewPath.storyboard, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewPath.view) as? BaseViewController else { return }
        viewController.data = data
        from.present(viewController, animated: true)
    }

    func setRootViewController(to viewPath: ViewPath, withNavigationController: Bool = false) {
        let storyboard = UIStoryboard(name: viewPath.storyboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewPath.view)
        if withNavigationController {
            configureNavigationController()
            navigationController?.setViewControllers([viewController], animated: true)
        } else {
            currentWindow?.rootViewController = viewController
            currentWindow?.makeKeyAndVisible()
        }
    }
}

extension NavigationRouter {
    private var loadingView: LoadingView {
        return LoadingView()
    }
    
    func showLoadingAnimation() {
        DispatchQueue.main.async {
            guard let window = self.currentWindow else { return }
            
            // Only add a new loading view if there isn't one already.
            if window.subviews.contains(where: { $0 is LoadingView }) == false {
                let loadingView = LoadingView(frame: window.bounds)
                window.addSubview(loadingView)
            }
        }
    }
    
    func hideLoadingAnimation() {
        DispatchQueue.main.async {
            guard let window = self.currentWindow else { return }
            
            // Find all loading views and remove them.
            window.subviews.forEach { subview in
                if subview is LoadingView {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}

