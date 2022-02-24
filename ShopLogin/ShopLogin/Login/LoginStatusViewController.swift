//
//  LoginStatusViewController.swift
//  ShopLogin
//
//  Created by Hwi kang on 2022/02/23.
//

import UIKit
import RxSwift

class LoginStatusViewController: UIViewController {
    public var loginViewModel : LoginViewModel!
    private var disposeBag : DisposeBag!
    
    @IBOutlet weak var loginStatusTitle: UILabel!
    @IBOutlet weak var loginStatusSubTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        disposeBag = DisposeBag()
        
        listenLoginStateOnserver()
    }
    
    private func listenLoginStateOnserver(){
        loginViewModel.getLoginObserver().subscribe {[weak self] (event) in
            guard let self = self ,
                  let loginState = event.element else {return}
            switch loginState {
            case .none:
                self.setDefaultView()
            case .onLogin:
                self.setOnLoginView()
            case .done, .fail:
                self.setLoginDoneView()
            }
        }.disposed(by: disposeBag)
    }
    
    func setDefaultView(){
        loginStatusTitle.text = "주문하신 상품의 계정으로 로그인하시면\n 배송정보를 실시간으로 볼 수 있어요."
        loginStatusSubTitle.text = "꽃피는시절 비회원 주문 및 SNS계정(페이스북/네이버 등으로 로그인 하여 주문하신 경우, \"주문 페이지 바로가기\"를 이용해주세요."
    }
    
    func setOnLoginView(){
        loginStatusTitle.text = "로그인 중입니다..."
        loginStatusSubTitle.text = ""
    }
    
    func setLoginDoneView(){
        loginStatusTitle.text = "로그인 성공!"
        loginStatusSubTitle.text = ""
    }
    

    

}
