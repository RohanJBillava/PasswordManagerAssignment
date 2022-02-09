//
//  customCell.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 05/02/22.
//

import UIKit

class customCell: UITableViewCell {

    
  
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var copyImg: UIImageView!
    
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var copyPass: UILabel!
    
    @IBOutlet weak var url: UILabel!
    
    
    
    func configureSite(site: Site) {
        logo.image = UIImage(named: site.name) ??  UIImage(systemName: "camera.on.rectangle.fill")
        url.text = site.url
        nameLabel.text = site.name
        copyPass.text = "copy password"
        copyImg.image = UIImage(systemName: "square.on.square.dashed")
    }

    func configureCell() {
        layer.borderColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        layer.borderWidth = 3
//        layer.cornerRadius = 25
        cellView.layer.cornerRadius = 13
        
    }
}
