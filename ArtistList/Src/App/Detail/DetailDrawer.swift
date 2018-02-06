//
//  DetailDrawer.swift
//  ArtistList
//
//  Created by Victor on 6/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class DetailDrawer: NSObject {
    
    var albums: [AlbumEntity]
    unowned let presenter: DetailPresenterInterface
    unowned let tableView: UITableView
    
    init(tableView: UITableView, presenter: DetailPresenterInterface) {
        
        self.albums = []
        self.tableView = tableView
        self.presenter = presenter
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DetailDrawer: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.albums.count > indexPath.row {
            
            let album: AlbumEntity = self.albums[indexPath.row]
            if let cellAlbum: DetailTableViewCell = cell as? DetailTableViewCell {
                
                cellAlbum.labelName.text = album.name
                cellAlbum.labelYear.text = album.year
                cellAlbum.setUrl(url: album.thumbail)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if self.albums.count > indexPath.row {
            
            let album: AlbumEntity = self.albums[indexPath.row]
            self.presenter.selectAlbum(album: album)
        }
    }
}

extension DetailDrawer: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.tableView.dequeueReusableCell(withIdentifier: "CellAlbum") ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.albums.count
    }
}

extension DetailDrawer: DetailDrawerInterface {
    
    func drawAlbums(albums: [AlbumEntity]) {
        
        self.albums = albums
        self.tableView.reloadData()
    }
}
