//
//  RestHandler.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class RestHandler {
    
    func get(url: URL, onSuccess: @escaping (_ data: Data) -> Void, onError: @escaping () -> Void) -> Void {
        
        let request: URLRequest = self.createRequest(url: url)
        self.sendRequest(request: request, onSuccess: onSuccess, onError: onError)
    }
    
    private func sendRequest (request: URLRequest, onSuccess: @escaping (_ data: Data) -> Void, onError: @escaping () -> Void) -> Void {
        
        let session: URLSession = URLSession.shared
        let task: URLSessionDataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let responseHttp: HTTPURLResponse = response as? HTTPURLResponse, responseHttp.statusCode <= 299 && responseHttp.statusCode >= 200, let dataUwrapped: Data = data {
                
                onSuccess(dataUwrapped)
            } else {
                
                onError()
            }
        }
        task.resume()
    }
    
    private func createRequest (url: URL) -> URLRequest {
        
        let request: URLRequest = URLRequest(url: url)
        return request
    }
}
