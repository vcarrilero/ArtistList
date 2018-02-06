//
//  DetailViewController.swift
//  ArtistList
//
//  Created by Victor on 6/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class DetailViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    var drawer: DetailDrawerInterface?
    var presenter: DetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Injector.sharedInstance.getDetail(detailView: self)
    }
}

extension DetailViewController: DetailViewInterface {
    
    func drawName(name: String?) {
        
        self.title = name
    }
    
    func goToDetail (url: URL) -> Void {
        
        if UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    var getDrawer: DetailDrawerInterface? {
        
        return self.drawer
    }
}
