//
//  BaseAPI.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 2.03.2024.
//

import Foundation
import Alamofire

class BaseAPI {
    let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequestConvertible,
                               success: @escaping (T) -> Void,
                               failure: @escaping (Error) -> Void) {
        NavigationRouter.shared.showLoadingAnimation()
        session.request(urlRequest).validate().responseDecodable(of: T.self) { response in
            print(response)
            NavigationRouter.shared.hideLoadingAnimation()
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(error as Error)
            }
        }
    }
}
