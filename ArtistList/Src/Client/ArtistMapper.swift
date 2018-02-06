//
//  ArtistMapper.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class ArtistMapper: JsonParser<ArtistListEntity> {
    
    let keyArtist: String = "artist"
    
    override func parseJson(json: [String: Any] ) throws -> ArtistListEntity {
        
        if let count: Int = json["resultCount"] as? Int, let resutls: [Any] = json["results"] as? [Any]  {
            
            var artists: [ArtistEntity] = []
            for item: Any in resutls {
             
                if let artist: ArtistEntity = self.parseArtists(item: item) {
                    
                    artists.append(artist)
                }
            }
            return ArtistListEntity(count: count, artists: artists)
        }
        throw ParserError.internalError
    }
    
    private  func parseArtists(item: Any) -> ArtistEntity? {
        
        if let json: [String: Any] = item as? [String: Any], let wrapperType: String = json["wrapperType"] as? String, wrapperType == self.keyArtist, let identifier: Int = json["artistId"] as? Int {
            
            let name: String? = json["artistName"] as? String
            let primaryGenere: String? = json["primaryGenreName"] as? String
            return ArtistEntity(name: name, identifier: identifier, primaryGenere: primaryGenere)
        } else {
        
            return nil
        }
    }
}
