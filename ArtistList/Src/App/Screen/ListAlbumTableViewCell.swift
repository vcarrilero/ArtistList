//
//  ListAlbumTableViewCell.swift
//  ArtistList
//
//  Created by Victor on 5/2/18.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class ListAlbumTableViewCell: ListTableViewCell {
    
    @IBOutlet weak var labelDiscography: UILabel!
    @IBOutlet weak var labelMore: UILabel!
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var indicatorOne: UIActivityIndicatorView!
    @IBOutlet weak var indicatorTwo: UIActivityIndicatorView!
    var sourceOne: URL?
    var sourceTwo: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.labelDiscography.text = "List_Discography".localized
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUrlOne(url: URL?) {
        
        if self.sourceOne != url  {
            
            self.imageOne.image = nil
            if let urlUwnrapped: URL = url {
                
                self.imageOne.image = #imageLiteral(resourceName: "cdaudio_unmount")
                self.indicatorOne.startAnimating()
                HelperImages.sharedInstance.getImage(url: urlUwnrapped, success: { [weak self] (image: UIImage) in
                    
                        if let weakSelf: ListAlbumTableViewCell = self, weakSelf.sourceOne == url  {
                        
                            weakSelf.imageOne.image = image
                            weakSelf.indicatorOne.stopAnimating()
                        }
                    }, fail: { [weak self] in
                        
                        if let weakSelf: ListAlbumTableViewCell = self, weakSelf.sourceOne == url  {
                            
                            weakSelf.indicatorOne.stopAnimating()
                        }
                })
            } else {
                
                self.imageOne.image = nil
                self.indicatorOne.stopAnimating()
            }
            self.sourceOne = url
        }
    }
    
    func setUrlTwo(url: URL?) {
        
        if self.sourceTwo != url  {
            
            if let urlUwnrapped: URL = url {
            
                self.imageTwo.image = #imageLiteral(resourceName: "cdaudio_unmount")
                self.indicatorTwo.startAnimating()
                HelperImages.sharedInstance.getImage(url: urlUwnrapped, success: { [weak self] (image: UIImage) in
                    
                    if let weakSelf: ListAlbumTableViewCell = self, weakSelf.sourceTwo == url  {
                        
                        weakSelf.imageTwo.image = image
                        weakSelf.indicatorTwo.stopAnimating()
                    }
                    }, fail: { [weak self] in
                        
                        if let weakSelf: ListAlbumTableViewCell = self, weakSelf.sourceTwo == url  {
                            
                            weakSelf.indicatorTwo.stopAnimating()
                        }
                })
            } else {
                
                self.imageTwo.image = nil
                self.indicatorTwo.stopAnimating()
            }
            self.sourceTwo = url
        }
    }
}
