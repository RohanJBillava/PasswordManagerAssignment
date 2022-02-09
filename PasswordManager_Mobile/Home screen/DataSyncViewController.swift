//
//  DataSyncViewController.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 06/02/22.
//

import UIKit

class DataSyncViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        view.alpha = 0.8
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.18
        view.layer.shadowOffset = .init(width: 0, height: 8)
        view.layer.shadowRadius = 10
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    

}
