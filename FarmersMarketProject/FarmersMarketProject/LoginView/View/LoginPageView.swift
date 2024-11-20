import UIKit

protocol LoginPageViewDelegate: AnyObject {
    func loginButtonWasPressed(user: UserToLogin)
    func signUpButtonPressed()
}

final class LoginPageView: UIView {
    
    var userToLogin = UserToLogin(username_or_email: "", password: "")
    
    weak var delegate: LoginPageViewDelegate?
    
    private let mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    private let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
    
    private let loginButton = CustomButton()
    
    private let emailUsernameLabel = CustomLabel(text: "Email / Username", color: .black, fontSize: 16)
    private let emailUsernameTextField = TextFieldView(placeH: "Your email / username", width: 300)
    
    private let passwordLabel = CustomLabel(text: "Password", color: .black, fontSize: 16)
    private let passwordTextField = TextFieldView(placeH: "Your password", width: 300)
    
    private let dontHaveAccountLabel = CustomLabel(text: "Don't have an account?", color: .black, fontSize: 15)
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.spacing = 15
        stack.addArrangedSubview(dontHaveAccountLabel)
        stack.addArrangedSubview(signUpButton)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginPageView {
    @objc private func signupButtonPressed() {
        delegate?.signUpButtonPressed()
    }
    
    @objc private func loginButtonPressed() {
        print("pressed")
        userToLogin.username_or_email = emailUsernameLabel.text!
        userToLogin.password = passwordTextField.text!
        
        delegate?.loginButtonWasPressed(user: userToLogin)
    }
}

extension LoginPageView {
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
        additionalSetup()
        setupButton(loginButton, #selector(loginButtonPressed), "LOGIN", .white, .black, 300)
    }
    
    private func addSubviews() {
        addGestureRecognizer(tap)
        
        addSubview(mainScrollView)
        
        mainScrollView.addSubview(mainContentView)
        
        mainContentView.addSubview(emailUsernameLabel)
        mainContentView.addSubview(emailUsernameTextField)
        
        mainContentView.addSubview(passwordLabel)
        mainContentView.addSubview(passwordTextField)
        
        mainContentView.addSubview(loginButton)
        
        mainContentView.addSubview(stack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainScrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainContentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            mainContentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainContentView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            emailUsernameLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 20),
            emailUsernameLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            emailUsernameTextField.topAnchor.constraint(equalTo: emailUsernameLabel.bottomAnchor, constant: 15),
            emailUsernameTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: emailUsernameTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            stack.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -150),
            stack.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor)
        ])
    }
    
    private func additionalSetup() {
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupButton(_ button: UIButton, _ action: Selector, _ title: String, _ color: UIColor, _ backgroundColor: UIColor, _ width: CGFloat) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = backgroundColor
        button.isEnabled = false
        button.addTarget(self, action: action, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.isEnabled = true
    }
    
}
