//
//  ViewController.swift
//  HotelInfo
//
//  Created by Duminda Namal on 2022-09-08.


import UIKit
import FBSDKLoginKit

// Add this to the body
class LoginViewController: UIViewController, LoginButtonDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    

        if let token = AccessToken.current,
           !token.isExpired {
            let token = token.tokenString

            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields":"email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)

            request.start{( connection, result, error )in
                print("\(result)")
            }
            print(">>>>>>>> Working <<<<<<<<<<")
            let homeViewController = HomeViewController()
            navigationController?.pushViewController(homeViewController, animated: true)
        }else{
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self

            //permissions
            loginButton.permissions = ["public_profile", "email"]

            view.addSubview(loginButton)
        }

    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString

        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields":"email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result)")
        }
        


        
      
        
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {

    }
}

