//
//  ListViewController.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class ListViewController: ViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var presenter: ListPresenterInterface?
    var drawer: ListDrawerInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Injector.sharedInstance.getList(listView: self)
        self.title = "List_Title".localized
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let presenterUnwrapped: ListPresenterInterface = self.presenter {
            
            presenterUnwrapped.search(text: searchBar.text ?? "")
        }
        searchBar.resignFirstResponder()
    }
}

extension ListViewController: ListViewInterface {
    
    func goToDetail () -> Void {
        
        self.performSegue(withIdentifier: "ToDetail", sender: nil)
    }
    
    var getDrawer: ListDrawerInterface? {
        
        return self.drawer
    }
}

