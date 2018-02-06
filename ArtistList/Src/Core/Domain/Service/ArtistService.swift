//
//  ArtistService.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class ArtistService {
    
    let maxCount: Int = 50
    let artistModel: ArtistModelInterface
    let albumModel: AlbumModelInterface
    weak var delegate: ArtistServiceDelegate?
    weak var updateArtistDelegate: UpadateArtistServiceDelegate?
    var artists: [ArtistCompleteEntity]
    var page: Int
    var canGoNext: Bool
    var artistSelected: ArtistCompleteEntity?
    var searchName: String?
    
    init(artistModel: ArtistModelInterface, albumModel: AlbumModelInterface) {
        
        self.artists = []
        self.page = 0
        self.canGoNext = false
        self.artistModel = artistModel
        self.albumModel = albumModel
    }
    
    private func getAlbums(artist: ArtistCompleteEntity) {
        
        self.albumModel.getAlbums(identifier: artist.artist.identifier, completion: { (transaction: Transaction<[AlbumEntity]>) in
            
            if var artistSelectedUnwrapped: ArtistCompleteEntity = self.artistSelected, artistSelectedUnwrapped.artist.identifier == artist.artist.identifier, let updateArtistDelegateUnwrapped: UpadateArtistServiceDelegate = self.updateArtistDelegate {
             
                switch transaction {
                case Transaction.success(let albums):
                    artistSelectedUnwrapped.albums = AlbumsComplete.success(albums: albums)
                    self.artistSelected = artistSelectedUnwrapped
                    updateArtistDelegateUnwrapped.updateArtist(artist: artistSelectedUnwrapped)
                    break
                case Transaction.fail:
                     artistSelectedUnwrapped.albums = AlbumsComplete.fail
                     self.artistSelected = artistSelectedUnwrapped
                     updateArtistDelegateUnwrapped.failArtist(error: TransactionError.Error)
                    break
                }
            }
            if let index: Int = self.artists.index(of: artist) {
                
                var artistToUpdate: ArtistCompleteEntity = self.artists[index]
                switch transaction {
                case Transaction.success(let albums):
                    artistToUpdate.albums = AlbumsComplete.success(albums: albums)
                    break
                case Transaction.fail:
                    artistToUpdate.albums = AlbumsComplete.fail
                    break
                }
                self.artists[index] = artistToUpdate
                if let delegateUnwrapped: ArtistServiceDelegate = self.delegate {
                
                    delegateUnwrapped.updateArtist(artist: artistToUpdate)
                }
            }
        })
    }
    
    private func getArtists () -> Void {
        
        if let searchNameUnwrapped: String = self.searchName {
            
            self.artistModel.getArtist(text: searchNameUnwrapped, page: self.page, completion: { (transaction: Transaction<ArtistListEntity>) in
                
                switch transaction {
                case Transaction.success(let artistList):
                    
                    self.page += artistList.count + 1
                    if artistList.count == self.maxCount {
                        
                        self.canGoNext = true
                    } else {
                        
                        self.canGoNext = false
                    }
                    var newElements: [ArtistCompleteEntity] = []
                    for artist: ArtistEntity in artistList.artists {
                        
                        let element: ArtistCompleteEntity = ArtistCompleteEntity(artist: artist, albums: AlbumsComplete.waiting)
                        newElements.append(element)
                    }
                    self.artists.append(contentsOf: newElements)
                    if let delegateUnwrapped: ArtistServiceDelegate = self.delegate {
                        
                        delegateUnwrapped.insertArtists(artists: newElements)
                    }
                    for artist: ArtistCompleteEntity in newElements {
                        
                        self.getAlbums(artist: artist)
                    }
                    break
                case Transaction.fail(let error):
                    self.canGoNext = false
                    if let delegateUnwrapped: ArtistServiceDelegate = self.delegate {
                        
                        delegateUnwrapped.failArtist(error: error)
                    }
                    break
                }
            })
        }
    }
}

extension ArtistService: ArtistServiceInterface {
    
    func getArtists(name: String) -> Void {
        
        self.artists = []
        self.page = 0
        self.canGoNext = false
        self.searchName = name
        self.artistModel.invalidate()
        self.getArtists()
    }
    
    func setArtist (artist: ArtistCompleteEntity) -> Void {
        
        self.artistSelected = artist
    }
    
    func nextArtists () -> Void {
        
        if self.canGoNext {
            
            self.getArtists()
        }
    }
    
    func getArtist (delegate: UpadateArtistServiceDelegate) -> Void {
        
        self.updateArtistDelegate = delegate
        if let artistSelectedUnwrapped: ArtistCompleteEntity = self.artistSelected {
            
            delegate.updateArtist(artist: artistSelectedUnwrapped)
            if case AlbumsComplete.fail = artistSelectedUnwrapped.albums {
                
                self.getAlbums(artist: artistSelectedUnwrapped)
            }
        }
    }
    
    func setDelegate (delegate: ArtistServiceDelegate) -> Void {
        
        self.delegate = delegate
    }
}
