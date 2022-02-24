//
//  LoginViewController.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/23.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    private var loginViewModel : LoginViewModel!
    private var disposeBag : DisposeBag!

    @IBOutlet weak var loginStatusView: UIView!
    @IBOutlet weak var loginInputView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel = LoginViewModel()
        disposeBag = DisposeBag()
        
        addSubView()
        setKeyboardNotification()
    }
    
    private func addSubView(){
        addStatusView()
        addInputView()
    }

    
    private func addStatusView(){
        if let vc = ViewManager.getViewController(storyboardName: "Main", identifier: "LoginStatusViewController") as? LoginStatusViewController {
            vc.loginViewModel = self.loginViewModel
            addSubview(child: vc, in: loginStatusView)
        }

    }
    private func addInputView(){
        if let vc = ViewManager.getViewController(storyboardName: "Main", identifier: "LoginInputViewController") as? LoginInputViewController {
            vc.loginViewModel = self.loginViewModel
            vc.loadViewIfNeeded()
            vc.idTextField.delegate = self
            vc.passwordTextField.delegate = self
            addSubview(child: vc, in: loginInputView)
        }
 
    }
    
    private func addSubview(child: UIViewController, in contentView:UIView) {
        addChild(child)
        child.view.frame = contentView.bounds
        contentView.addSubview(child.view)
        child.didMove(toParent: self)
    }
}


extension LoginViewController : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);

    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if let info = sender.userInfo {
            let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            self.view.frame.origin.y = -keyboardFrame.size.height
        }

    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    
}
