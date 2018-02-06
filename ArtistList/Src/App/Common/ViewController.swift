//
//  ViewController.swift
//  ArtistList
//
//  Created by Victor on 6/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ViewInterface {
    
    func showLoading () -> Void {
        
    }
    
    func hiddeLoading () -> Void {
        
    }
    
    func showAlert ( text: String ) -> Void {
        
        let alert: UIAlertController = UIAlertController(title: "Common_Alert".localized, message: text, preferredStyle: UIAlertControllerStyle.alert)
        let okAction: UIAlertAction = UIAlertAction(title: "Common_Accept".localized, style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

