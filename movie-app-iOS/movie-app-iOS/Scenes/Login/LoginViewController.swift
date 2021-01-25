//
//  ViewController.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 07/11/2020.
//

import UIKit
import SnapKit

protocol LoginDisplayLogic {
    func displaySuccessAlert(prompt: String)
    func displayFailureAlert(prompt: String)
}

class LoginViewController: UIViewController {
    var loginInteractor: LoginBusinessLogic?
    var titleText = UILabel()
    var subtitleText = UILabel()
    var containerStackView = UIStackView()
    var inputFieldContainer = UIView()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var inputFieldSeparator = UIView()
    var placeHolderColor = UIColor(red: 0.736, green: 0.73, blue: 0.778, alpha: 1)
    var loginButton = UIButton()
    var signupButton = UIButton()
    var paddingView = UIView()
    var validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.1098039216, blue: 0.2980392157, alpha: 1)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func setup() {
        let presenter = LoginPresenter()
        presenter.loginView = self
        let worker = LoginWorker()
        let interactor = LoginInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
        self.loginInteractor = interactor
    }
    
    func layoutViews() {
        setupTitleView()
        setupSubtitleView()
        setupStackView()
        setupInputContainerView()
        setupTextfields()
        setupLoginButton()
        setupCreateNewAccount()
    }
    
    func setupTitleView() {
        view.addSubview(titleText)
        titleText.text = LoginConstants.titleText
        titleText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleText.font = UIFont.boldSystemFont(ofSize: 32)
        titleText.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(100)
            make.left.equalTo(view).offset(20)
        }
    }
    
    func setupSubtitleView() {
        view.addSubview(subtitleText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        subtitleText.attributedText = NSMutableAttributedString(string: LoginConstants.subtitleText, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        subtitleText.numberOfLines = 0
        subtitleText.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subtitleText.font = UIFont.systemFont(ofSize: 18)
        subtitleText.lineBreakMode = .byWordWrapping
        subtitleText.snp.makeConstraints { (make) in
            make.top.equalTo(titleText.snp.bottom).offset(10)
            make.left.equalTo(view).offset(20)
        }
    }
    
    func setupStackView() {
        view.addSubview(containerStackView)
        containerStackView.alignment = .top
        containerStackView.axis = .vertical
        containerStackView.distribution = .fillProportionally
        containerStackView.addArrangedSubview(inputFieldContainer)
        containerStackView.addArrangedSubview(paddingView)
        containerStackView.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleText.snp.bottom).offset(30)
            make.height.equalTo(view.snp.height).multipliedBy(0.15)
            make.right.equalTo(view.snp.right).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
        }
    }
    
    func setupInputContainerView() {
        inputFieldContainer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        inputFieldContainer.layer.cornerRadius = 20
        inputFieldContainer.snp.makeConstraints { (make) in
            make.left.equalTo(containerStackView)
            make.right.equalTo(containerStackView)
            make.height.equalTo(containerStackView).multipliedBy(0.9)
        }
        inputFieldContainer.clipsToBounds = true
    }
    
    func setupTextfields() {
        inputFieldSeparator = UIView()
        inputFieldContainer.addSubview(inputFieldSeparator)
        inputFieldSeparator.backgroundColor = UIColor(red: 0.957, green: 0.965, blue: 0.988, alpha: 1)
        inputFieldSeparator.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputFieldContainer)
            make.left.equalTo(8)
            make.height.equalTo(1.0)
            make.right.equalTo(0)
        }
        
        emailTextField = UITextField()
        inputFieldContainer.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.attributedPlaceholder = NSAttributedString(string: LoginConstants.emailPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        emailTextField.font = emailTextField.font?.withSize(15)//
        emailTextField.borderStyle = .none
        emailTextField.textColor = UIColor(red: 0.148, green: 0.139, blue: 0.269, alpha: 1)
        emailTextField.keyboardType = .emailAddress
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                 for: .editingChanged)
        emailTextField.autocapitalizationType = .none
        emailTextField.tintColor = UIColor(red: 0.98, green: 0.878, blue: 0.184, alpha: 1)
        emailTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(inputFieldSeparator).multipliedBy(0.5)
            make.right.equalTo(inputFieldContainer).offset(-20)
            make.left.equalTo(inputFieldContainer).offset(20)
        }
        
        passwordTextField = UITextField()
        inputFieldContainer.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.attributedPlaceholder = NSAttributedString(string: LoginConstants.passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        passwordTextField.font = passwordTextField.font?.withSize(15)
        passwordTextField.borderStyle = .none
        passwordTextField.textColor = UIColor(red: 0.148, green: 0.139, blue: 0.269, alpha: 1)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.tintColor = UIColor(red: 0.98, green: 0.878, blue: 0.184, alpha: 1)
        passwordTextField.snp.makeConstraints { (make) in
            make.right.equalTo(inputFieldSeparator).offset(-80)
            make.centerY.equalTo(inputFieldSeparator).multipliedBy(1.5)
            make.left.equalTo(inputFieldContainer).offset(20)
        }
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.setTitle(LoginConstants.loginButtonTitle, for: .normal)
        loginButton.contentHorizontalAlignment = .center
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        loginButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0.2490100599, alpha: 1), for: .normal)
        loginButton.layer.cornerRadius = 20
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerStackView.snp.bottom).offset(40)
            make.right.equalTo(view.snp.right).offset(-20)
            make.left.equalTo(view.snp.left).offset(20)
            make.height.equalTo(view).multipliedBy(0.07)
        }
    }
    
    func setupCreateNewAccount() {
        view.addSubview(signupButton)
        signupButton.setTitle(LoginConstants.signupButtonTitle, for: .normal)
        signupButton.contentHorizontalAlignment = .center
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        signupButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.height.equalTo(view).multipliedBy(0.05)
        }
    }
}


extension LoginViewController: UITextFieldDelegate, LoginDisplayLogic {
    func displaySuccessAlert(prompt: String) {
        let view = ListMovieViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    func displayFailureAlert(prompt: String) {
        self.handleNetworkError(prompt: prompt)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text
        else {
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
                                                        ValidationConstants.invalidEmailMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: ValidationConstants.alertDismiss, style: .default))
            self.present(alertController, animated: true, completion: nil)
            print(ValidationConstants.invalidPasswordTitle)
            return
        }
        if (isValidateEmail == true || isValidatePass == true) {
            let user = LoginDataModel(email: email , password: password )
            loginInteractor?.login(userDetail: user)
        }
        
    }
    
    @objc func handleSignUp() {
        let view = SignupViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}
