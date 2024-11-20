import UIKit

protocol CreateAccountScrollViewDelegate: AnyObject {
    func continueButtonPressed()
    func alreadyHaveAccountPressed()
    func performRequestCreateUser(user: Buyer)
}

final class CreateAccountScrollView: UIView {
    
    private var userCreated = Buyer(username: "", email: "", password: "", first_name: "", last_name: "", role: "")
    
    private var acceptedRules: Bool = false
    
    weak var delegate: CreateAccountScrollViewDelegate?
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
    
    private let acceptTermsLabel: UILabel = {
        let label = UILabel()
        label.text = "I accept the terms and privacy policy"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private lazy var acceptTermsButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor(named: "Color")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(acceptRulesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.titleLabel?.textColor = .black
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(alreadyHaveAccountButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackForAlreadyHaveAccount: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(alreadyHaveAccountLabel)
        stack.addArrangedSubview(alreadyHaveAccountButton)
        stack.alignment = .center
        return stack
    }()
    
    private lazy var stackForAcceptRules: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(acceptTermsButton)
        stack.addArrangedSubview(acceptTermsLabel)
        return stack
    }()
    
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
    
    private let continueButton = CustomButton()
    
    private let nameLabel = CustomLabel(text: "Name", color: .black, fontSize: 16)
    let nameTextField = TextFieldView(placeH: "Your Name", width: 300)
    
    private let surnameLabel = CustomLabel(text: "Surname", color: .black, fontSize: 16)
    let surnameTextField = TextFieldView(placeH: "Your surname", width: 300)
    
    private let usernameLabel = CustomLabel(text: "Username", color: .black, fontSize: 16)
    let usernameTextField = TextFieldView(placeH: "Your username", width: 300)
    
    private let emailLabel = CustomLabel(text: "Email", color: .black, fontSize: 16)
    let emailTextField = TextFieldView(placeH: "Your email", width: 300)
    
    private let passwordLabel = CustomLabel(text: "Password", color: .black, fontSize: 16)
    let passwordTextField = TextFieldView(placeH: "Your password", width: 300)
    
    private let roleLabel = CustomLabel(text: "Role", color: .black, fontSize: 16)
    let roleTextField = TextFieldView(placeH: "e.g., Farmer", width: 300)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CreateAccountScrollView {
    
    private func setupView() {
        addSubviews()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        setupButton(continueButton, #selector(continueButtonPressed), "CONTINUE", .white, UIColor(named: "Color")!, 300)
    }
    
    private func addSubviews() {
        addGestureRecognizer(tap)
        
        addSubview(mainScrollView)
        
        mainScrollView.addSubview(mainContentView)
        
        mainContentView.addSubview(nameLabel)
        mainContentView.addSubview(nameTextField)
        
        mainContentView.addSubview(surnameLabel)
        mainContentView.addSubview(surnameTextField)
        
        mainContentView.addSubview(usernameLabel)
        mainContentView.addSubview(usernameTextField)
        
        mainContentView.addSubview(emailLabel)
        mainContentView.addSubview(emailTextField)
        
        mainContentView.addSubview(passwordLabel)
        mainContentView.addSubview(passwordTextField)
        
        mainContentView.addSubview(roleLabel)
        mainContentView.addSubview(roleTextField)
        
        mainContentView.addSubview(stackForAcceptRules)
        
        mainContentView.addSubview(continueButton)
        
        mainContentView.addSubview(stackForAlreadyHaveAccount)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainScrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainContentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height+100),
            mainContentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainContentView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            //name
            nameLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            nameTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            //surname
            surnameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            surnameLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 15),
            surnameTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            //username
            usernameLabel.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 15),
            usernameTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            //emai
            emailLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 15),
            emailTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            //password
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 15),
            passwordTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            //role
            roleLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            roleLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            roleTextField.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 15),
            roleTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            //stack
            stackForAcceptRules.topAnchor.constraint(equalTo: roleTextField.bottomAnchor, constant: 20),
            //stackForAcceptRules.heightAnchor.constraint(equalToConstant: 50),
            stackForAcceptRules.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            //continue button
            continueButton.topAnchor.constraint(equalTo: stackForAcceptRules.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            stackForAlreadyHaveAccount.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            stackForAlreadyHaveAccount.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor)
        ])
    }
    
    private func setupButton(_ button: UIButton, _ action: Selector, _ title: String, _ color: UIColor, _ backgroundColor: UIColor, _ width: CGFloat) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = .gray
        button.isEnabled = false
        button.addTarget(self, action: action, for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    }
    
    @objc private func continueButtonPressed() {
        userCreated.email = emailTextField.text!
        userCreated.first_name = nameTextField.text!
        userCreated.last_name = surnameTextField.text!
        userCreated.username = usernameTextField.text!
        userCreated.password = passwordTextField.text!
        userCreated.role = roleTextField.text!.lowercased()
        
        delegate?.performRequestCreateUser(user: userCreated)
        delegate?.continueButtonPressed()
    }
    
    @objc private func acceptRulesButtonPressed() {
        acceptedRules.toggle()
        if acceptedRules {
            acceptTermsButton.backgroundColor = UIColor(named: "Color")!
            continueButton.backgroundColor = UIColor(named: "Color")!
            continueButton.isEnabled = true
        } else {
            acceptTermsButton.backgroundColor = .white
            continueButton.backgroundColor = .gray
            continueButton.isEnabled = false
        }
    }
    
    @objc private func alreadyHaveAccountButtonPressed() {
        delegate?.alreadyHaveAccountPressed()
    }
}
