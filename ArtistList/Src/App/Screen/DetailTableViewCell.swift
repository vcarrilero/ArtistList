//
//  DetailTableViewCell.swift
//  ArtistList
//
//  Created by Victor on 6/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var imageAlbum: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var source: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUrl(url: URL?) {
        
        if self.source != url  {
            
            self.imageAlbum.image = nil
            if let urlUwnrapped: URL = url {
                
                self.imageAlbum.image = #imageLiteral(resourceName: "cdaudio_unmount")
                self.indicator.startAnimating()
                HelperImages.sharedInstance.getImage(url: urlUwnrapped, success: { [weak self] (image: UIImage) in
                    
                    if let weakSelf: DetailTableViewCell = self, weakSelf.source == url  {
                        
                        weakSelf.imageAlbum.image = image
                        weakSelf.indicator.stopAnimating()
                    }
                    }, fail: { [weak self] in
                        
                        if let weakSelf: DetailTableViewCell = self, weakSelf.source == url  {
                            
                            weakSelf.indicator.stopAnimating()
                        }
                })
            } else {
                
                self.imageAlbum.image = nil
                self.indicator.stopAnimating()
            }
            self.source = url
        }
    }
}

