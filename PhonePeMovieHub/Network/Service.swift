//
//  Service.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import Foundation
import Alamofire

typealias OnResponse = (_ responseData: Data?,_ response: [String: Any]?, _ error: FilteredError?, _ responseCode: Int?) -> Void

class Service {
    
    var manager: Session! = Session()
            
    func get(_ api: API, parameters: [String: Any]?, onResponse: @escaping OnResponse) {
        var path = api.path + "?"
        if let parameters = parameters {
            path += parameters.asQuery
        }
        call(path, parameters: nil, type: .get, onResponse: onResponse)
    }

    func post(_ api: API, parameters: [String: Any]?, onResponse: @escaping OnResponse) {
        call(api.path, parameters: parameters, type: .post, onResponse: onResponse)
    }
    
    func put(_ api: API, parameters: [String: Any]?, onResponse: @escaping OnResponse) {
        call(api.path, parameters: parameters, type: .put, onResponse: onResponse)
    }
    
    func delete(_ api: API, parameters: [String: Any]?, onResponse: @escaping OnResponse) {
        var path = api.path + "?"
        if let parameters = parameters {
            path += parameters.asQuery
        }
        call(path, parameters: nil, type: .delete, onResponse: onResponse)
    }

    private func call(_ path: String, parameters: [String: Any]?, type: HTTPMethod, onResponse: @escaping OnResponse) {

        let urlString = API.baseURL + path
        manager.request(urlString, method: type, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in

            switch response.result {
            case .success(let result):
                onResponse(response.data, result as? [String: Any], nil, response.response?.statusCode)
            case .failure(let error):
                if let data = response.data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                            onResponse(nil, json, .unknown(error: error), error.asAFError?.responseCode)
                        } else {
                            onResponse(nil, nil, .unknown(error: error), error.asAFError?.responseCode)
                        }
                    } catch _ as NSError {
                        onResponse(nil, nil, .unknown(error: error), error.asAFError?.responseCode)
                    }
                } else {
                    onResponse(nil, nil, .unknown(error: error), error.asAFError?.responseCode)
                }
            }
        }
    }

}
