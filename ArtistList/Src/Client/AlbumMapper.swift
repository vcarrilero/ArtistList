//
//  AlbumMapper.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class AlbumMapper: JsonParser<[AlbumEntity]> {
    
    let keyAlbum: String = "collection"
    let formatterEnter: DateFormatter
    let formatterExit: DateFormatter

    override init(data: Data) {
        
        self.formatterEnter = DateFormatter()
        self.formatterExit = DateFormatter()
        super.init(data: data)
        self.formatterEnter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        self.formatterExit.dateFormat = "yyyy"
    }
    
    override func parseJson(json: [String: Any] ) throws -> [AlbumEntity] {
        
        if let resutls: [Any] = json["results"] as? [Any]  {
            
            var albums: [AlbumEntity] = []
            for item: Any in resutls {
                
                if let album: AlbumEntity = self.parseAlbum(item: item) {
                    
                    albums.append(album)
                }
            }
            return albums
        }
        throw ParserError.internalError
    }
    
    private func parseAlbum(item: Any) -> AlbumEntity? {
        
        if let json: [String: Any] = item as? [String: Any], let wrapperType: String = json["wrapperType"] as? String, wrapperType == self.keyAlbum {
            
            let name: String? = json["collectionName"] as? String
            let thumbail: URL?
            if let artworkUrl60: String = json["artworkUrl60"] as? String {

                thumbail = URL(string: artworkUrl60)
            } else {
                
                thumbail = nil
            }
            let year: String?
            if let releaseDate: String = json["releaseDate"] as? String, let date: Date = self.formatterEnter.date(from: releaseDate) {
                
                year = self.formatterExit.string(from: date)
            } else {
                
               year = nil
            }
            let collectionViewUrl: URL?
            if let link: String = json["collectionViewUrl"] as? String {
                
                collectionViewUrl = URL(string: link)
            } else {
                
                collectionViewUrl = nil
            }
            return AlbumEntity(name: name, thumbail: thumbail, year: year, url: collectionViewUrl)
        } else {
            
            return nil
        }
    }
}

