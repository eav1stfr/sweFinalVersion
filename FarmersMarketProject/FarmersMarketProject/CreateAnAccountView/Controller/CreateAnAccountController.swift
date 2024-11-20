import UIKit

final class CreateAccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private var createAccountScrollView = CreateAccountScrollView()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

private extension CreateAccountViewController {
    private func setupView() {
        view.backgroundColor = .white
        createAccountScrollView.delegate = self
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(createAccountLabel)
        view.addSubview(createAccountScrollView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            createAccountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            createAccountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            createAccountScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            createAccountScrollView.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 10),
            createAccountScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            createAccountScrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

extension CreateAccountViewController: CreateAccountScrollViewDelegate {
    func performRequestCreateUser(user: Buyer) {
        let url = URL(string: "https://farmer-market-zlmy.onrender.com/api/register/buyer/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let data = try! JSONEncoder().encode(user)
        request.httpBody = data
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            if statusCode == 400 {
                print("error: not valid request")
            } else {
                print(statusCode)
                let defaults = UserDefaults.standard
                defaults.set(user.first_name, forKey: "Name")
                defaults.set(user.last_name, forKey: "Surname")
                defaults.set(user.email, forKey: "Email")
                defaults.set(true, forKey: "IsAuthorized")
            }
        }
        
        task.resume()
    }
    
    
    func alreadyHaveAccountPressed() {
        print("already have account button pressed")
        let newViewController = LoginPageViewController()
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func continueButtonPressed() {
        print("continue button pressed")
        let newViewController = MainMenuTabBarController()
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createAccountScrollView.passwordTextField.endEditing(true)
        createAccountScrollView.emailTextField.endEditing(true)
        createAccountScrollView.usernameTextField.endEditing(true)
        createAccountScrollView.surnameTextField.endEditing(true)
        createAccountScrollView.nameTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
