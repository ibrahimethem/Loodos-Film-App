//
//  Alert.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 3.03.2024.
//

import Foundation
import UIKit

struct AlertModel {
    typealias AlertActionType = (String, AlertActions)
    let title: String
    let detail: String
    let actions: [AlertActionType]
    
    init(title: String, detail: String, actions: [AlertActionType]) {
        self.title = title
        self.detail = detail
        self.actions = actions
    }
    
    init(error: Error) {
        title = "Something went wrong"
        detail = error.localizedDescription
        actions = [("OK", .ok)]
    }
}

enum AlertActions {
    case ok
    case cancel
    case searchAgain
    case tryAgain
}

enum Alert {
    case noResultFound
    case error(Error)
    case noNetwork
    
    var model: AlertModel {
        switch self {
        case .error(let error):
            return AlertModel(error: error)
        case .noResultFound:
            return AlertModel(title: "No Result", detail: "No movie found with this name", actions: [("OK", .ok), ("Search Again", .searchAgain)])
        case .noNetwork:
            return AlertModel(title: "No Connection", detail: "You need to have a internet connection to continue", actions: [("Try Again", .tryAgain)])
        }
    }
}
