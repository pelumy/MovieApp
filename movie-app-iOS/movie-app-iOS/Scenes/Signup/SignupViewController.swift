//
//  SignupViewController.swift
//  movie-app-iOS
//
//  Created by mac on 07/11/2020.
//

import UIKit
import SnapKit

protocol SignupDisplayLogic {
    func displaySuccessAlert(prompt: String)
    func displayFailureAlert(prompt: String)
}

class SignupViewController: UIViewController {
    var signupInteractor: SignupBusinessLogic?
    var titleLabel = UILabel()
    var inputFieldContainer = UIView()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var userNameTextField = UITextField()
    var signupButton = UIButton()
    var loginButton = UIButton()
    var validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func setup() {
        let presenter = SignupPresenter()
        presenter.signupView = self
        let worker = SignupWorker()
        let interactor = SignupInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
        self.signupInteractor = interactor
    }
    
    func setupLayout() {
        setupSignupTitle()
        setupInputViewContainer()
        setupTextfields()
        setupSignupButton()
        setuploginButton()
    }
    
    func setupSignupTitle() {
        view.addSubview(titleLabel)
        titleLabel.text = SingupConstants.title
        titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0.2490100599, alpha: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(100)
        }
    }
    
    func setupInputViewContainer() {
        view.addSubview(inputFieldContainer)
        inputFieldContainer.backgroundColor = .white
        inputFieldContainer.layer.cornerRadius = 20
        inputFieldContainer.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(24).priority(750)
            make.left.equalTo(20).priority(750)
            make.right.equalTo(-20).priority(750)
            make.height.equalTo(view.snp.height).multipliedBy(0.2)
            inputFieldContainer.clipsToBounds = true
        }
    }
    
    func setupTextfields() {
        inputFieldContainer.addSubview(userNameTextField)
        userNameTextField.font?.withSize(15)
        userNameTextField.borderStyle = .none
        userNameTextField.autocapitalizationType = .none
        userNameTextField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        userNameTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let namePlaceHolder = NSAttributedString(string: SingupConstants.userName , attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.736, green: 0.73, blue: 0.778, alpha: 1)])
        userNameTextField.attributedPlaceholder = namePlaceHolder
        userNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(inputFieldContainer).offset(20)
            make.right.equalTo(inputFieldContainer).offset(-20)
            make.left.equalTo(inputFieldContainer).offset(20)
        }
        
        inputFieldContainer.addSubview(emailTextField)
        let emailPlaceHolder = NSAttributedString(string: SingupConstants.email, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.736, green: 0.73, blue: 0.778, alpha: 1)])
        emailTextField.attributedPlaceholder = emailPlaceHolder
        emailTextField.font?.withSize(15)
        emailTextField.borderStyle = .none
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.right.equalTo(inputFieldContainer).offset(-20)
            make.left.equalTo(inputFieldContainer).offset(20)
        }
        
        inputFieldContainer.addSubview(passwordTextField)
        let passwordPlaceHolder = NSAttributedString(string: SingupConstants.password, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.736, green: 0.73, blue: 0.778, alpha: 1)])
        passwordTextField.attributedPlaceholder = passwordPlaceHolder
        passwordTextField.font?.withSize(15)
        passwordTextField.borderStyle = .none
        passwordTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.right.equalTo(inputFieldContainer).offset(-20)
            make.left.equalTo(inputFieldContainer).offset(20)
        }
    }
    
    func setupSignupButton() {
        view.addSubview(signupButton)
        signupButton.setTitle(SingupConstants.title, for: .normal)
        signupButton.contentHorizontalAlignment = .center
        signupButton.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.1098039216, blue: 0.2980392157, alpha: 1)
        signupButton.titleLabel?.font.withSize(15)
        signupButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        signupButton.layer.cornerRadius = 20
        signupButton.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        signupButton.snp.makeConstraints { (make) in
            make.top.equalTo(inputFieldContainer.snp.bottom).offset(50)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(inputFieldContainer.snp.height).multipliedBy(0.35)
        }
    }
    
    func setuploginButton() {
        view.addSubview(loginButton)
        loginButton.setTitle(SingupConstants.loginTitle, for: .normal)
        loginButton.contentHorizontalAlignment = .center
        loginButton.backgroundColor = .clear
        loginButton.titleLabel?.font.withSize(14)
        loginButton.setTitleColor(#colorLiteral(red: 0.03529411765, green: 0.1098039216, blue: 0.2980392157, alpha: 1), for: .normal)
        loginButton.addTarget(self, action: #selector(handlelogin), for: .touchUpInside)
        loginButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(view).offset(-40)
            make.height.equalTo(inputFieldContainer.snp.height).multipliedBy(0.1)
        }
    }
    
    @objc func handlelogin() {
        let view = LoginViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func handleSignup() {
        guard let userNname = userNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text
        else {
            return
        }
        let isValidateName = self.validation.validateName(name: userNname)
        if (isValidateName == false) {
            let alertController = UIAlertController(title: ValidationConstants.invalidNameTitle, message:
                                                        ValidationConstants.invalidNameMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: ValidationConstants.alertDismiss, style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if (isValidateEmail == false) {
            let alertController = UIAlertController(title: ValidationConstants.invalidEmailTitle, message:
                                                        ValidationConstants.invalidEmailMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: ValidationConstants.alertDismiss, style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let isValidatePass = self.validation.validatePassword(password: password)
        if (isValidatePass == false) {
            let alertController = UIAlertController(title: ValidationConstants.invalidPasswordTitle, message:
                                                        ValidationConstants.invalidPasswordMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: ValidationConstants.alertDismiss, style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if (isValidateEmail == true || isValidatePass == true) {
            let userDetail = SignupDataModel(username: userNname, email: email, password: password)
            signupInteractor?.signup(userDetail: userDetail)
        }
    }
}

extension SignupViewController: SignupDisplayLogic {
    func displaySuccessAlert(prompt: String) {
        let view = LoginViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    func displayFailureAlert(prompt: String) {
        self.handleNetworkError(prompt: prompt)
    }
}
