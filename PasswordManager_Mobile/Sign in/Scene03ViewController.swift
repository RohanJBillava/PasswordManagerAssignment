//
//  Scene03ViewController.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 03/02/22.
//

import UIKit

protocol transferLoginCredentials {
    func transferLoginDetails(of user: User)
}

class Scene03ViewController: UIViewController {

    @IBOutlet weak var signInLabel: UILabel!
    
    
    @IBOutlet weak var mobileNoField: UITextField!
    
    
    @IBOutlet weak var mpinField: UITextField!
    
    
    @IBOutlet weak var reEnteredMpinField: UITextField!
    
    var delegate: transferLoginCredentials!
    let _users = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        assignTextFieldDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       createGradientLayer()
    }
    
    func assignTextFieldDelegates() {
        mobileNoField.delegate = self
        mpinField.delegate = self
        reEnteredMpinField.delegate = self
    }
    
    private func configureLabels() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signInLabelClicked(_:)))
        signInLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(named: "#20BBFF")!
        let color2 =  UIColor(named: "#0E85FF")!
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func signInLabelClicked(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }

    
    @IBAction func signInBtnClicked(_ sender: Any) {
       
        if let mobileNo = mobileNoField.text,
           let pin = mpinField.text,
           let pin2 = reEnteredMpinField.text {
            
            if mobileNo.isEmpty || pin.isEmpty || pin2.isEmpty {
                showAlert(title: "Empty Data", message: "please fill all the fields")
            }else
            {
                if pin != pin2
                {
                    showAlert(title: "INVALID MPIN", message: "MPIN doesnt match")
                }else
                {
                    let user = User(mobileNumber: mobileNo , mpin: pin)
                    
                    
                    if _users.authenticateSignup(mobileNO: mobileNo)
                    {
                        delegate.transferLoginDetails(of: user)
                        _users.add(user: user)
                        navigationController?.popViewController(animated: false)
                    }
                    else
                    {
                        showAlert(title: "Duplicate Data", message: "Mobile Number already exists")
                    }
                }
            
            
            }
        }
        
       
    }
    
    
}

extension Scene03ViewController: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == mpinField {
            if let mpin = mpinField.text {
                if mpin.count != 4 {
                   showAlert(title: "Invalid MPIN", message: "MPIN must be 4 numbers")
                } else {
                    if let _ = Int(mpin){
                       print("valid mpin")
                    }
                    else {
                        showAlert(title: "Invalid MPIN", message: "MPIN must be 4 numbers")
                        
                    }
                }
            }
        }
        
        if textField == mobileNoField {
            if let mobileNo = mobileNoField.text {
                if mobileNo.count != 10 {
                    showAlert(title: "Invalid ", message: "Mobile Number")
                }
                else {
                    guard Int(mobileNo) != nil else {
                        showAlert(title: "Invalid ", message: "Mobile Number")
                        return
                    }
                }
            }
            
        }
        
        
        
        
    }
}


