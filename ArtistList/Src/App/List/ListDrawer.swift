//
//  ListDrawer.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class ListDrawer: NSObject {
    
    var artists: [ArtistCompleteEntity]
    unowned let presenter: ListPresenterInterface
    unowned let tableView: UITableView
    let semaphore = DispatchSemaphore(value: 1)

    init(tableView: UITableView, presenter: ListPresenterInterface) {
        
        self.artists = []
        self.tableView = tableView
        self.presenter = presenter
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListDrawer: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.artists.count > indexPath.row {
            
            let artist: ArtistCompleteEntity = self.artists[indexPath.row]
            if let cellArtist: ListTableViewCell = cell as? ListTableViewCell {
                
                cellArtist.labelArtist.text = artist.artist.name
                cellArtist.labelGenere.text = artist.artist.primaryGenere
            }
            if let cellAlbums: ListAlbumTableViewCell = cell as? ListAlbumTableViewCell {
                
                if case AlbumsComplete.success(let albums) = artist.albums {
                
                    let urlOne: URL?
                    let urlTwo: URL?
                    if albums.count > 0 {
                        
                       urlOne = albums[0].thumbail
                    } else {
                    
                        urlOne = nil
                    }
                    if albums.count > 1 {
                        
                       urlTwo = albums[1].thumbail
                    } else {
                        
                        urlTwo = nil
                    }
                    cellAlbums.setUrlOne(url: urlOne)
                    cellAlbums.setUrlTwo(url: urlTwo)
                    if albums.count > 2 {
                        
                        cellAlbums.labelMore.text = "... \(albums.count - 2) \("List_More".localized)"
                    } else {
                     
                        cellAlbums.labelMore.text = ""
                    }
                }
            }
            if self.artists.count == indexPath.row + 1 {
                
                self.presenter.reachedEndPage()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if self.artists.count > indexPath.row {
            
            let artist: ArtistCompleteEntity = self.artists[indexPath.row]
            self.presenter.selectArtist(artist: artist)
        }
    }
}

extension ListDrawer: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.artists.count > indexPath.row {
            
            let artist: ArtistCompleteEntity = self.artists[indexPath.row]
            if case AlbumsComplete.success = artist.albums {
                
                return self.tableView.dequeueReusableCell(withIdentifier: "CellAlbum") ?? UITableViewCell()
            }
        }
        return self.tableView.dequeueReusableCell(withIdentifier: "CellArtist") ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.artists.count
    }
}

extension ListDrawer: ListDrawerInterface {
    
    func insertArtists(artist: [ArtistCompleteEntity]) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            self.semaphore.wait()
            var indexPaths: [IndexPath] = []
            let actual: Int = self.artists.count
            for i: Int in 0..<artist.count {
                
                let index: IndexPath = IndexPath(row: actual + i, section: 0)
                indexPaths.append(index)
            }
            self.artists.append(contentsOf: artist)
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
                self.tableView.endUpdates()
                self.semaphore.signal()
            }
        }
    }
    
    func updateArtists(artist: ArtistCompleteEntity) {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            if let i: Int = self.artists.index(of: artist) {
             
                self.semaphore.wait()
                let index: IndexPath = IndexPath(row: i, section: 0)
                let indexPaths: [IndexPath] = [index]
                self.artists[i] = artist
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
                    self.tableView.endUpdates()
                    self.semaphore.signal()
                }
            }
        }
    }
    
    func clear() {
        
        self.artists.removeAll()
        self.tableView.reloadData()
    }
}
