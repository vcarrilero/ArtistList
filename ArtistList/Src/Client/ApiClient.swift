//
//  ApiClient.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class ApiClient {
    
    let network: NetworkClient
    let basePath: String = "https://itunes.apple.com/%@"
    let artistPath: String = "search?media=music&entity=musicArtist&term=%@&limit=50&offset=%ld&lang=%@"
    let albumPath: String = "lookup?id=%ld&entity=album&limit=200&lang=%@"
    
    
    init() {
        
        self.network = NetworkClient()
    }
    
    private func createRequest(url: URL, success: @escaping (_ data: Data) -> (), fail: @escaping () -> ()) {
        
        let request: URLRequest = URLRequest(url: url)
        self.network.addRequest(request: request, completion: { (data: Data?, _ response: URLResponse?, _ error: Error?) in
            
            if let responseHttp: HTTPURLResponse = response as? HTTPURLResponse, responseHttp.statusCode >= 200 && responseHttp.statusCode < 300, let dataUwnrapped: Data = data {
                
                success(dataUwnrapped)
            } else {
                
                fail()
            }
        })
    }
}

extension ApiClient: AlbumRepositoryInterface {
    
    func getAlbum(identifier: Int, completion: @escaping (_ transcation: Transaction<[AlbumEntity]>) -> Void ) -> Void {
        
        let path: String = String(format: self.albumPath, identifier, Locale.current.identifier)
        let source: String = String(format: self.basePath, path)
        if let url: URL = URL(string: source) {
            
            self.createRequest(url: url, success: { (data: Data) in
                
                let parser: AlbumMapper = AlbumMapper(data: data)
                do {
                    
                    let albums: [AlbumEntity] =  try parser.parse()
                    completion(Transaction.success(albums))
                } catch {
                    
                    completion(Transaction.fail(TransactionError.Error))
                }
            }, fail: {
                
                completion(Transaction.fail(TransactionError.Error))
            })
        } else {
            
            completion(Transaction.fail(TransactionError.Error))
        }
    }
}

extension ApiClient: ArtistRepositoryInterface {
    
    func getArtists(name: String, page: Int, completion: @escaping (_ transcation: Transaction<ArtistListEntity>) -> Void ) -> Void {
        
        let path: String = String(format: self.artistPath, name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "", page, Locale.current.identifier)
        let source: String = String(format: self.basePath, path)
        if let url: URL = URL(string: source) {
            
            self.createRequest(url: url, success: { (data: Data) in
                
                let parser: ArtistMapper = ArtistMapper(data: data)
                do {
                    
                    let artistList: ArtistListEntity =  try parser.parse()
                    completion(Transaction.success(artistList))
                } catch {
                    
                    completion(Transaction.fail(TransactionError.Error))
                }
            }, fail: {
                
                completion(Transaction.fail(TransactionError.Error))
            })
        } else {
            
            completion(Transaction.fail(TransactionError.Error))
        }
    }
}

extension ApiClient: NetworkRepositoryInterface {
    
    func invalidate() {
        
        self.network.invalidate()
    }
}
