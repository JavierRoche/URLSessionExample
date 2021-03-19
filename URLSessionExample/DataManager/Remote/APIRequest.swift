//
//  APIRequest.swift
//  URLSessionsExample
//
//  Created by APPLE on 16/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

enum Method: String, CaseIterable {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

/// Implementacion del protocolo que genera una request para un API
extension APIRequest {
    /// Variable ya validada con la base de la URL
    var baseURL: URL {
        guard let baseURL: URL = URL(string: Constants.apiURL) else {
            fatalError(Constants.invalidUrl)
        }
        return baseURL
    }
    
    
    // MARK: Functions
    
    /// Funcion que devuelve la URL definitiva que se pasa al API
    func getRequest() -> URLRequest {
        /// Primero definimos cual sera la URL con el recurso a llamar
        let url: URL = baseURL.appendingPathComponent(path)
        
        /// Comprobamos y construimos la URL de acuerdo con RFC 3986
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError(Constants.componentsError)
        }
        
        /// Incorporamos los parametros si los hubiera
        if !parameters.isEmpty {
            components.queryItems = parameters.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        /// Construimos la URL final
        guard let finalURL = components.url else {
            fatalError(Constants.finalURLError)
        }
        
        /// Ahora construimos la URLRequest para la URLSession con el metodo de la request y las headers necesarias
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.addValue(Constants.contentTypeValue, forHTTPHeaderField: Constants.contentType)
        
        return request
    }
}
