//
//  APISession.swift
//  MarbelApp
//
//  Created by APPLE on 10/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

/// Enumerado con los posibles errores que se generan segun la respuesta del API
enum APISessionError: Error {
    case httpError(Int)
    case apiError(ApiError)
}

struct ApiError: Codable {
    let action: String?
    let errors: [String]?
}

final class APISession {
    /// La sesion es una URLSession con una configuracion por defecto para el acceso al API
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func sendRequest<T: APIRequest>(request: T, completion: @escaping(Result<T.Response?, Error>) -> ()) {
        /// Obtenemos la request asociada al API
        let request = request.getRequest()
        
        /// Lanzamos el acceso al API
        let task = self.session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                /// Si hay respuesta erronea del servidor, intentamos decodificar el data en la estructura ApiError, para dar una respuesta de error al usuario ...
                if let data = data {
                    do {
                        let dataModel = try JSONDecoder().decode(ApiError.self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(Result.failure(APISessionError.apiError(dataModel)))
                        }
                        
                    } catch {
                        DispatchQueue.main.async {
                            completion(Result.failure(APISessionError.httpError(httpResponse.statusCode)))
                        }
                    }
                
                /// ... o simplemente devolvemos el status code sino podemos decodificar el error
                } else {
                    DispatchQueue.main.async {
                        completion(Result.failure(APISessionError.httpError(httpResponse.statusCode)))
                    }
                }
                return
            }
            
            /// Si la respuesta del API no es erronea intentamos decodificar los datos recibidos
            if let data = data, data.count > 0 {
                do {
                    let dataModel = try JSONDecoder().decode(T.Response.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(Result.success(dataModel))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion(Result.success(nil))
                    }
                }
            }
        }
        
        task.resume()
    }
}
