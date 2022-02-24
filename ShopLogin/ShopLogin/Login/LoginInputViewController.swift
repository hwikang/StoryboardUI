//
//  LoginInputViewController.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/23.
//

import UIKit
import RxSwift

class LoginInputViewController: UIViewController {
    public var loginViewModel : LoginViewModel!

    @IBOutlet weak var idInputView: UIView!
    @IBOutlet weak var passwordInputView: UIView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginButtonView: UIView!
    @IBOutlet weak var autoLoginLabel: UILabel!
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginSpinner: UIActivityIndicatorView!
    @IBOutlet weak var autoLoginTermsView: UIView!
    
    private var isAutoLoginSelected : Bool = false
    

    private var disposeBag : DisposeBag!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        disposeBag = DisposeBag()
        
        showOrHideAutoLoginButtonView()
        listenLoginStateOnserver()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUI()
    }
    
    private func listenLoginStateOnserver(){
        loginViewModel.getLoginObserver().subscribe {[weak self] (event) in
            guard let self = self,
                  let loginState = event.element else {return}
            switch loginState {
            case .onLogin, .done:
                self.changeViewByLoginState(onLogin:true)
           
            default:
                self.changeViewByLoginState(onLogin:false)

            }
        }.disposed(by: disposeBag)
    }
    
   
    
    
    @IBAction func onClickAutoLoginButton(_ sender: UIButton) {
        isAutoLoginSelected = !isAutoLoginSelected
        setAutoLoginButtonImage()
    }
   
    @IBAction func onClickLogin(_ sender: UIButton) {
        let isAgreedBefore = loginViewModel.getAutoLoginAgreement()
        if(isAutoLoginSelected || isAgreedBefore){
            loginViewModel.setLoginState(state: .onLogin)
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
                self?.loginViewModel.setLoginState(state: .done)
                self?.saveAutoLoginAgree()
            }
        }else{
            ToastMessageManager.showToast(message: "약관에 동의해야 로그인 가능합니다.")
        }
        
    }
    
    private func saveAutoLoginAgree(){
        loginViewModel.setAutoLoginAgreement()
    }
   

}



extension LoginInputViewController{

    private func setUI(){
        setTextFieldsUI()
        setAutoLoginButtonUI()
        
    }
    
    private func setTextFieldsUI(){
        setTextFieldPlaceHolder()
        drawInputViewBorder()
    }
    
    private func setAutoLoginButtonUI(){
        setAutoLoginLabel()
        setAutoLoginButtonImage()
    }
    
    private func setTextFieldPlaceHolder(){
        idTextField.attributedPlaceholder = NSAttributedString(string: "꽃피는시절 아이디", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])

    }
    
    private func drawInputViewBorder(){
        idInputView.layer.addSublayer(getBorder())
        passwordInputView.layer.addSublayer(getBorder())
    }
    
    private func getBorder() -> CALayer{
        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: idInputView.frame.size.height - 1, width: idInputView.frame.size.width, height: 1)
        return border
    }
    
    private func setAutoLoginLabel(){
        let colorString = NSMutableAttributedString(string: "자동 로그인 약관에 동의", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        let redColor = UIColor(red: 245/255, green: 66/255, blue: 120/255, alpha: 1)
        colorString.addAttribute(NSAttributedString.Key.foregroundColor, value: redColor, range: NSRange(location:0,length:9))
        autoLoginLabel.attributedText = colorString
    }
    
    private func setAutoLoginButtonImage(){
        if(isAutoLoginSelected){
            autoLoginButton.setImage(UIImage(named: "checked_normal"), for: .normal)
            autoLoginButton.setImage(UIImage(named: "checked_pressed"), for: .highlighted)
        }else{
          
            autoLoginButton.setImage(UIImage(named: "unchecked_normal"), for: .normal)
            autoLoginButton.setImage(UIImage(named: "unchecked_pressed"), for: .highlighted)
        }
    }
    
  
    private func changeViewByLoginState(onLogin:Bool){
        changeLoginButtonViewByLoginState(onLogin: onLogin)
        setUnableView(onLogin: onLogin)
    }
    
    private func changeLoginButtonViewByLoginState(onLogin:Bool){
        if(onLogin){
            loginButton.setTitle("", for: .normal)
            loginSpinner.isHidden = false
        }else{
            loginButton.setTitle("로그인", for: .normal)
            loginSpinner.isHidden = true

        }
    }
    
    private func setUnableView(onLogin:Bool){
        if(onLogin){
            self.view.alpha = 0.5
            self.view.isUserInteractionEnabled = false
        }else{
            self.view.alpha = 1.0
            self.view.isUserInteractionEnabled = true
        }
    }
    
   
    
    private func showOrHideAutoLoginButtonView(){
        let isAgreed = loginViewModel.getAutoLoginAgreement()
        if(isAgreed){
            setAutoLoginViewHidden(hidden: true)
            setAutoLoginTermsViewHidden(hidden: false)
        }else{
            setAutoLoginViewHidden(hidden: false)
            setAutoLoginTermsViewHidden(hidden: true)
        }
    }
    
    private func setAutoLoginViewHidden(hidden:Bool){
        autoLoginButtonView.translatesAutoresizingMaskIntoConstraints = false
        autoLoginButtonView.heightAnchor.constraint(equalToConstant: 0).isActive = hidden
    }
    
    private func setAutoLoginTermsViewHidden(hidden:Bool){
        autoLoginTermsView.isHidden = hidden
    }
}
