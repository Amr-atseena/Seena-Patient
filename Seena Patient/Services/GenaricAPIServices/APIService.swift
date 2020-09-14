//
//  APIService.swift
//  OJO Workforce
//
//  Created by RKAnjel on 8/6/20.
//  Copyright © 2020 Sat Finder. All rights reserved.
//

import Foundation
import Moya

class APIService<T> where T: TargetType {
    private var provider: MoyaProvider<T>!
    init() {
        let endpointClosure = { (target: T) -> Endpoint in
           let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
           var request = try? defaultEndpoint.urlRequest()
           request?.cachePolicy = .useProtocolCachePolicy
           return defaultEndpoint
       }
        let isLive = RemoteServiceType.shared.isLive
        func JSONResponseDataFormatter(_ data: Data) -> String {
            do {
                let dataAsJSON = try JSONSerialization.jsonObject(with: data)
                let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
            } catch {
                return String(data: data, encoding: .utf8) ?? ""
            }
        }
        let stubClosure = isLive ? MoyaProvider<T>.neverStub : MoyaProvider<T>.immediatelyStub
        provider = MoyaProvider<T>(endpointClosure: endpointClosure,
                                   stubClosure: stubClosure,
                                   session: Session.default, plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init( requestData: JSONResponseDataFormatter, responseData: JSONResponseDataFormatter), logOptions: .verbose))])
        provider.session.sessionConfiguration.timeoutIntervalForRequest = 20
        provider.session.sessionConfiguration.timeoutIntervalForResource = 20
    }
    func request<C: Codable>(target: T, objType: C.Type, completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let successResponse = try response.filterSuccessfulStatusCodes()
                    let object = try JSONDecoder().decode(objType, from: successResponse.data)
                    completionHandler(.success(object))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
