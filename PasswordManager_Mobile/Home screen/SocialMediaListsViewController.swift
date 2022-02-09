//
//  SocialMediaListsViewController.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 04/02/22.
//

import UIKit

class SocialMediaListsViewController: UIViewController, UISearchBarDelegate {

    

    @IBOutlet weak var siteCountBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var backBtn: UIButton!
    
    var sitesObj = Sites()
    var data:[Site] = []
    
    var filteredData: [Site] = []
    
    
    // MARK: View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        addLeftNavBarItems()
        addRightNavBarItems()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        backBtn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        data = sitesObj.allSites
        filteredData = data
        searchBar.isHidden = true
        backBtn.isHidden = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.title = ""
        siteCountBtn.setTitle(String(sitesObj.allSites.count), for: .normal)
        
    }
    
    // MARK: Search Bar Configuration
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        }else {
            for site in sitesObj.allSites {
                if site.name.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(site)
                }
            }
        }
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    // MARK: Nav Bar Configuration
    private func addLeftNavBarItems() {

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05490196078, green: 0.5215686275, blue: 1, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "burger_menu"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "passImg"), style: .plain, target: self, action: nil)
        ]
        
    }
   
    private func addRightNavBarItems() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "profile"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(named: "sync_icn"), style: .plain, target: self, action: #selector(syncData)),
            UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(searchTapped))
        ]
        
    }

    // MARK: Button Functionalities
    @objc func searchTapped() {
        print("search btn tapped")
        searchBar.isHidden = false
        backBtn.isHidden = false
    }
    
    @objc func syncData() {
        guard let vc = storyboard?.instantiateViewController(identifier: "DataSyncViewController") as? DataSyncViewController else {
            return
        }
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.dismiss(animated: true, completion: nil)
            })
        })
        
    }
    
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        filteredData = data
        tableView.reloadData()
        searchBar.isHidden = true
        backBtn.isHidden = true
    }
    
    
    
    @IBAction func addBtnClicked(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "SitesDetailsViewController") as? SitesDetailsViewController else {
            return
        }
        vc.title = "Add Site"
        vc.isNewSite = true
        vc.dataTransferDelegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: TableView methods

extension SocialMediaListsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "SitesDetailsViewController") as? SitesDetailsViewController else {
            return
        }
        vc.temporarySite = filteredData[indexPath.row]
        vc.title = "Site Details"
        vc.dataTransferDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let site = filteredData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! customCell
        cell.configureSite(site: site)
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        114
    }
    
}

// MARK: Custom Protocols
extension SocialMediaListsViewController: DataTransferProtocol {
    func transferDataOf(Existing site: Site) {
        if let indexPath = tableView.indexPathForSelectedRow {
            filteredData[indexPath.row] = site
            data[indexPath.row] = site
            sitesObj.allSites[indexPath.row] = site
        }
        tableView.reloadData()
    }
    
    func transferData(ofNew site: Site) {
        sitesObj.allSites.append(site)
        filteredData.append(site)
        data.append(site)
        tableView.reloadData()
        showToast(message: "Saved Successfully", x: 20, y: self.view.frame.height - 100, width: 320, height: 56, font: UIFont(name: "OpenSans-Regular", size: 20), radius: 28)
    }
    
    
}
