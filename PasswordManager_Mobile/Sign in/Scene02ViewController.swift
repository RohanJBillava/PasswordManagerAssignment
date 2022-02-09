//
//  Scene02ViewController.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 02/02/22.
//

import UIKit

class Scene02ViewController: UIViewController {

    @IBOutlet weak var passManagerLabel: UILabel!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var orLabelNearSignInBtn: UILabel!
    @IBOutlet weak var fingerprintLabel: UILabel!
    
    
    
    @IBOutlet weak var mobileNumberField: UITextField!
    
    @IBOutlet weak var mpinField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        assignTextFieldDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createGradientLayer()
        navigationController?.navigationBar.isHidden = true
    }
    
    private func assignTextFieldDelegates() {

        mobileNumberField.delegate = self
        mpinField.delegate = self
    }
    
    
    
    private func configureLabels() {
        orLabel.isHidden = false
        orLabelNearSignInBtn.isHidden = true
        fingerprintLabel.isHidden = false
        passManagerLabel.textColor = UIColor(named: "#FBFBFB")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signUpClicked(_:)))
        signUpLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(named: "#20BBFF")!
        let color2 =  UIColor(named: "#0E85FF")!
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func signUpClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "Scene03ViewController") as? Scene03ViewController else {
            return
        }
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
        
    }

    @IBAction func signInBtnClicked(_ sender: Any)
    {
        let _users = Users()
        print("signin btn clicked")
        guard let mobileNo = mobileNumberField.text,
              let mpin = mpinField.text else {
            return
        }

        
        if mobileNo.isEmpty || mpin.isEmpty
        {
            showAlert(title: "Empty Fields", message: "please fill all the fields")
        }else
        {
            
            if _users.authenticateSignIn(user: User(mobileNumber: mobileNo, mpin: mpin)) {
                orLabel.isHidden = true
                orLabelNearSignInBtn.isHidden = false
                fingerprintLabel.isHidden = true
                
                guard let vc = storyboard?.instantiateViewController(identifier: "SocialMediaListsViewController") as? SocialMediaListsViewController else
                {
                    return
                }
                vc.modalPresentationStyle = .fullScreen
                
                showToast(message: "Congrtats!!! Success\nSignin to access the vault", x: 20, y: self.view.frame.height - 100, width: 320, height: 66, font: UIFont(name: "OpenSans-Regular", size: 16), radius: 33)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                    self.navigationController?.pushViewController(vc, animated: true)
                })
            }
            else
            {
                showAlert(title: "Intruder", message: "Please sign up. Outsiders are not allowed")
            }
            
        }
        
    }
    
    
}

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let DismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (action) -> Void in print("try again")
        }
        alert.addAction(DismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showToast(message: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, font: UIFont?, radius: CGFloat) {
        
        let toastLabel = UILabel(frame: CGRect(x:  x, y: y, width: width, height: height))
        toastLabel.textAlignment = .center
        toastLabel.font = font ?? UIFont.systemFont(ofSize: 16)
        toastLabel.numberOfLines = 0
        toastLabel.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        toastLabel.textColor = .white
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = radius
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { isCompleted in
            toastLabel.removeFromSuperview()
        }
        )
    }
}

extension Scene02ViewController: transferLoginCredentials, UITextFieldDelegate {
    func transferLoginDetails(of user: User) {
        mobileNumberField.text = user.mobileNumber
        mpinField.text = user.mpin
    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileNumberField {
            guard let mobileNo = mobileNumberField.text else {
                return
            }
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
        
        
        if textField == mpinField {
            if let mpin = mpinField.text {
                if mpin.count != 4 {
                   showAlert(title: "Invalid MPIN", message: "MPIN must be 4 numbers")
                } else {
                    guard Int(mpin) != nil else {
                        showAlert(title: "Invalid MPIN", message: "MPIN must be 4 numbers")
                        return
                    }
                }
            }
        }
        
        
    }
    
    
}
