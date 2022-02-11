//
//  expViewController.swift
//  PasswordManager_Mobile
//
//  Created by Rohan J Billava on 09/02/22.
//

import UIKit

class SignInViewController: UIViewController {

  // MARK: IB Outlets
    
    
    @IBOutlet weak var eyeBtn: UIButton!
    
    
    @IBOutlet weak var passManagerLabel: UILabel!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var orLabel: UILabel!
    
    
    @IBOutlet weak var orLabelNearSignInBtn: UILabel!
    
    
    @IBOutlet weak var fingerPrintLabel: UILabel!
    
    
    @IBOutlet weak var mobileNumberField: UITextField!
    
    
   
    @IBOutlet weak var mpinField: UITextField!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    

    @IBOutlet weak var signInLabel: UILabel!
    
    
   
    @IBOutlet weak var signUpMobileNo: UITextField!
    
  
    @IBOutlet weak var signUpMpin: UITextField!
    
    
    @IBOutlet weak var reEnteredMpinField: UITextField!
    

    @IBOutlet weak var signInandUpView: UIView!
    
    // MARK: PROPERTIES
    let _users = Users()
    let underLine = UIView()
    
    
    
    
    // MARK: Views Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
        assignTextFieldDelegates()
        scrollView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        createGradientLayer()
        hideNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        underLine.frame =  CGRect(x: 0, y: signInandUpView.frame.size.height - 4, width: 81, height: 4)
        underLine.backgroundColor = #colorLiteral(red: 1, green: 0.6352941176, blue: 0.1333333333, alpha: 1)
        underLine.layer.cornerRadius = 3.3
        signInandUpView.addSubview(underLine)
    }
    
    // MARK: UI CONFIG
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func assignTextFieldDelegates() {

        mobileNumberField.delegate = self
        mpinField.delegate = self
        signUpMobileNo.delegate = self
        signUpMpin.delegate = self
        reEnteredMpinField.delegate = self
    }
    
    private func configureLabels() {
        orLabel.isHidden = false
        orLabelNearSignInBtn.isHidden = true
        fingerPrintLabel.isHidden = false
        passManagerLabel.textColor = UIColor(named: "#FBFBFB")
        
        let signUptapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(signUpLabelClicked(_:)))
        let signIntapGesture = UITapGestureRecognizer(target: self, action: #selector(signInLabelClicked(_:)))
        signUpLabel.addGestureRecognizer(signUptapGestureRecognizer)
        signInLabel.addGestureRecognizer(signIntapGesture)
    }

    
    
    private func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(named: "#20BBFF")!
        let color2 =  UIColor(named: "#0E85FF")!
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    // MARK: IB ACTIONS
    
    @objc func signUpLabelClicked(_ sender: Any) {
        animateUnderLine(in: .right)
        scrollView.setContentOffset(CGPoint(x: 375.0, y: 0.0), animated: true)
        
    }
    
    @objc func signInLabelClicked(_ sender: Any) {
        animateUnderLine(in: .left)
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
    }
    
    
    
    @IBAction func signInBtnOfSignUpViewClicked(_ sender: Any) {
       
        if let mobileNo = signUpMobileNo.text,
           let pin = signUpMpin.text,
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
                    if _users.authenticateSignup(mobileNO: mobileNo)
                    {
                        _users.add(user: User(mobileNumber: mobileNo, mpin: pin))
                        mobileNumberField.text = mobileNo
                        mpinField.text = pin
                        orLabel.isHidden = true
                        orLabelNearSignInBtn.isHidden = false
                        fingerPrintLabel.isHidden = true
                        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                        showToast(message: "Congrtats!!! Success\nSignin to access the vault", x: 20, y: self.view.frame.height - 100, width: 320, height: 66, font: UIFont(name: "OpenSans-Regular", size: 16), radius: 33)
                    }
                    else
                    {
                        showAlert(title: "Duplicate Data", message: "Mobile Number already exists")
                    }
                }
            
            
            }
        }
        
    }
    
    
    @IBAction func signInBtnClicked(_ sender: Any) {
        
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

                guard let vc = storyboard?.instantiateViewController(identifier: "SocialMediaListsViewController") as? SocialMediaListsViewController else
                {
                    return
                }
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)

            }
            else
            {
                showAlert(title: "Intruder", message: "Please sign up. Outsiders are not allowed")
            }
            
        }
        
    }
    // MARK: ANIMATION STUFFS

    enum Animate {
        case left
        case right
    }
    
    private func animateUnderLine(in direction: Animate) {
        
        switch direction {
        case .right:
            UIView.animate(withDuration: 0.5, animations: {
                self.underLine.frame = CGRect(x: self.signInandUpView.frame.size.width - 81, y: self.signInandUpView.frame.size.height - 4, width: 81, height: 4)
            })
        case .left:
            UIView.animate(withDuration: 0.5, animations: {
                self.underLine.frame = CGRect(x: 0, y: self.signInandUpView.frame.size.height - 4, width: 81, height: 4)
            })
        }
        
        
    }
}




// MARK: Text Field delegates
extension SignInViewController:  UITextFieldDelegate {

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
                        showAlert(title: "Invalid MPIN", message: "Alphabets are not allowed")
                        return
                    }
                }
            }
        }
        
        if textField == signUpMpin {
            if let mpin = signUpMpin.text {
                if mpin.count != 4 {
                   showAlert(title: "Invalid MPIN", message: "MPIN must be 4 numbers")
                } else {
                    guard Int(mpin) != nil else {
                        showAlert(title: "Invalid MPIN", message: "Alphabets are not allowed")
                        return
                    }
                }
            }
        }
        
        if textField == signUpMobileNo {
            if let mobileNo = signUpMobileNo.text {
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

// MARK: SCROLL VIEW DELEGATE

extension SignInViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= 0 && scrollView.contentOffset.x <= 150 {
            UIView.animate(withDuration: 0.5, animations: {
                self.underLine.frame = CGRect(x: 0, y:self.signInandUpView.frame.size.height - 4 , width: 81, height: 4)
            })
        }else if scrollView.contentOffset.x > 150 && scrollView.contentOffset.x <= 375 {
            UIView.animate(withDuration: 0.5, animations: {
                self.underLine.frame = CGRect(x: self.signInandUpView.frame.size.width - 81, y:self.signInandUpView.frame.size.height - 4 , width: 81, height: 4)
            })
        }
        
//        print(scrollView.contentOffset.x)
    }
    
}




// MARK: ALERT AND TOAST

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
