//
//  Request.swift
//  prueba_charts
//
//  Created by dti on 27/03/19.
//  Copyright © 2019 dti. All rights reserved.
//

import Foundation

class Request {
    
    typealias CompletionHandler = (_ data:Data?, _ response:URLResponse?, _ error: Error?) -> Void
    
    
    class func asyncWebServiceGet(stringURL:String,completionHandler:@escaping CompletionHandler) {
        let url: URL = URL(string:stringURL)!
        let request : NSMutableURLRequest = NSMutableURLRequest(url: url)
        let session : URLSession = URLSession.shared
        request.httpMethod = "GET"
        let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
        task.resume()
    }
    
    
    
    
    
    class func getCursosAprobablesAprobadosXCiclo(completionHandler: @escaping CompletionHandler) {
        let url = "https://blackhole.dev/DIego%20-%20Cursos%20aprobables%20y%20aprobados%20por%20ciclo.json"
        asyncWebServiceGet(stringURL: url, completionHandler: completionHandler)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //Function for web service data interpretation. All controllers must call this function to access the server data.
    class func processRequestData(response:URLResponse?,data: Data?, error: Error?) -> Any? {
        //Process headers after data recovery
        //PucpRequest.processRequestHeaders(response: response)
        if(data != nil) {
            let res = response as! HTTPURLResponse;
            if(res.statusCode >= 200 && res.statusCode < 300) {
                let responseData:String = NSString(data:data! as Data, encoding:String.Encoding.utf8.rawValue)! as String
                print("Response ===> \(responseData)")
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data! as Data, options:JSONSerialization.ReadingOptions.mutableContainers)
                    return jsonData
                } catch _ {
                   print( "Error al obtener la información de responseData")
                    return ErrorC.server
                }
            }
        } else {
            print(error!)
            if let nsError = error as NSError? {
                if nsError.domain == "PUCP" {
                    return ErrorC.server
                }
            } else {
                return nil
            }
        }
        return nil
    }
    
    
    
    
    class func validateResponseData(jsonData:Any?, response: URLResponse? = nil) -> Int {
        if response != nil {
            let res = response as! HTTPURLResponse
            if(res.statusCode >= 200 && res.statusCode < 300) {
                if jsonData != nil {
                    if let error =  jsonData as? Int {
                        print("Error al validar data \(error)")
                        return ErrorC.server
                    }
                    //View controller validations
                    return ErrorC.none
                }
            } else {
                return ErrorC.server
            }
        }
        //No response but there is an error saved in jsonData
        if jsonData != nil {
            if let error =  jsonData as? Int {
                if error == ErrorC.server {
                    return ErrorC.server
                }
            }
        }
        return ErrorC.connection
    }
    
    class ErrorC {
        static let none = 0
        static let connection = 1
        static let server = 2
    }
}
