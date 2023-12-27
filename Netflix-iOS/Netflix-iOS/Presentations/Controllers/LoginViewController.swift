//
//  SearchViewController.swift
//  Netflix-iOS
//
//  Created by Seonwoo Kim on 12/26/23.
//

import UIKit
import SnapKit
import KakaoSDKUser
import AuthenticationServices

final class LoginViewController: UIViewController {
    let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
    func setAppleLoginButton() {
                authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
                self.view.addSubview(authorizationButton)
                
                // AutoLayout
                authorizationButton.translatesAutoresizingMaskIntoConstraints = false
            }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        //사용자의 이름과 이메일에 대한 인증요청
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    let kakaoButton: UIButton = {
        let kakaoButton = UIButton()
        kakaoButton.setTitle("kakaoButton", for: .normal)
        kakaoButton.addTarget(self, action: #selector(kakaoButtonTaped), for: .touchUpInside)
        kakaoButton.translatesAutoresizingMaskIntoConstraints = false
        kakaoButton.backgroundColor = .lightGray
        return kakaoButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppleLoginButton()
        setUI()
    }
    
    func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        view.addSubview(kakaoButton)
        view.addSubview(authorizationButton)
    }
    
    func setConstraints() {
        
        kakaoButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
        
        authorizationButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(kakaoButton.snp.bottom).offset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
    }
    
    @objc private func kakaoButtonTaped() {
        print(UserApi.isKakaoTalkLoginAvailable())
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print("Kakao login error: \(error)")
                } else {
                    print("Kakao login success.")
                    if let token = oauthToken {
                        print("Access Token: \(token.accessToken)")
                        // 여기에 필요한 작업 수행
                    }
                }
            }
        }
    }
    
    @objc func appleButtonTaped() {
        print("tap")
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    //로그인 성공
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // You can create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("identifyTokenString: \(identifyTokenString)")
            print("🚨", appleIDCredential)
            }
            
            print("useridentifier: \(userIdentifier)")
            if let fullName = appleIDCredential.fullName {
                // fullName이 제공된 경우에만 수행할 동작
                print("fullName: \(fullName)")
            } else {
                print("fullName is nil")
            }

            if let email = appleIDCredential.email {
                // email이 제공된 경우에만 수행할 동작
                print("email: \(email)")
            } else {
                print("email is nil")
            }
            
            //Move to MainPage
            //let validVC = SignValidViewController()
            //validVC.modalPresentationStyle = .fullScreen
            //present(validVC, animated: true, completion: nil)
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 로그인 실패(유저의 취소도 포함)
        print("login failed - \(error.localizedDescription)")
    }
}
