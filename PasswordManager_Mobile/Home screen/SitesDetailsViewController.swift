//
//  SitesDetailsViewController.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 06/02/22.
//

import UIKit

protocol DataTransferProtocol {
    func transferData(ofNew site: Site)
    func transferDataOf(Existing site: Site)
}






class SitesDetailsViewController: UIViewController {

    
    @IBOutlet weak var urlField: UITextField!
    
    
    @IBOutlet weak var siteNameField: UITextField!
    
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var sectorField: UITextField!
    
    @IBOutlet weak var notesField: UITextField!
    
    @IBOutlet weak var sitePassField: UITextField!
    
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var updateBtn: UIButton!
    
    var temporarySite: Site?
    let sitesOBJ = Sites()
    var dataTransferDelegate: DataTransferProtocol!
    var isNewSite = false
    var editBarBtnItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.editBarBtnItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editBtnTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        assignSitesDataToTextFields()
        if isNewSite {
            saveBtn.isHidden = false
            resetBtn.isHidden = false
            navigationItem.rightBarButtonItem = nil
        } else {
            saveBtn.isHidden = true
            resetBtn.isHidden = true
            navigationItem.rightBarButtonItem = self.editBarBtnItem
        }
        
        updateBtn.isHidden = true
    }

    
    @objc func editBtnTapped(){
        print("edit btn tapped")
        updateBtn.isHidden = false
        navigationItem.rightBarButtonItem = nil
        navigationItem.title = "Edit"
    }
    
    
    private func assignSitesDataToTextFields() {
        guard let site = temporarySite else {
            return
        }
        urlField.text = site.url
        siteNameField.text = site.name
        sectorField.text = site.sector
        userNameField.text = site.username
        sitePassField.text = site.password
        notesField.text = site.notes
    }
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        print("update btn clicked")
        if let urlText = urlField.text,
           let siteNameText = siteNameField.text,
           let sectorText = sectorField.text,
           let userNameText = userNameField.text,
           let sitePassText = sitePassField.text,
           let notesText = notesField.text {
            
            let site = Site(_url: urlText, _siteName: siteNameText, _sector: sectorText, _username: userNameText, _password: sitePassText, _notes: notesText)
            dataTransferDelegate.transferDataOf(Existing: site)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        if let urlText = urlField.text,
           let siteNameText = siteNameField.text,
           let sectorText = sectorField.text,
           let userNameText = userNameField.text,
           let sitePassText = sitePassField.text,
           let notesText = notesField.text {
            
            if urlText.isEmpty || siteNameText.isEmpty || sectorText.isEmpty || userNameText.isEmpty || sitePassText.isEmpty  {
                
                let alert = UIAlertController(title: "Empty Data", message: "Please fill all the fields", preferredStyle: .alert)
                let DismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (action) -> Void in print("try again")
                }
                alert.addAction(DismissAction)
                self.present(alert, animated: true, completion: nil)
            } else {
            
                let site = Site(_url: urlText, _siteName: siteNameText, _sector: sectorText, _username: userNameText, _password: sitePassText, _notes: notesText)
                
                print("saved sucessfully")
                
                if isNewSite {
                    dataTransferDelegate.transferData(ofNew: site)
                }
    
                navigationController?.popViewController(animated: true)
                
            }
        }
        
        
        
        
        
    }
    
    @IBAction func resetBtnClicked(_ sender: Any) {
        
        urlField.text = ""
        siteNameField.text = ""
        sectorField.text = ""
        userNameField.text = ""
        sitePassField.text = ""
        notesField.text = ""
        
    }
    
}
