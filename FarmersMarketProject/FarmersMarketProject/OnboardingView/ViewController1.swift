import UIKit

final class ViewController: UIViewController {

    private var labels: [String] = ["Welcome to Farmer's Market!", "Hello", "Bro bro bro"]
    private var currentIndex = 0
    
    private lazy var nextButton = CustomButton()
    private let createAccountButton = CustomButton()
    private let loginButton = CustomButton()
    
    
    @objc private func loginButtonPressed() {
        let newVC = LoginPageViewController()
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true, completion: nil )
    }
    
    @objc private func createAccountButtonPressed() {
        let newViewController = CreateAnAccountView()
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }

    @objc private func nextButtonPressed() {
        currentIndex += 1
        
        UIView.animate(withDuration: 0.5, animations: { [self] in
            if currentIndex == 1 {
                firstLabel.alpha = 0
                secondLabel.alpha = 1
            } else if currentIndex == 2 {
                secondLabel.alpha = 0
                finalLabel.alpha = 1
                fruitBasketPhoto.alpha = 0
                deliveryGuyPhoto.alpha = 1
                nextButton.frame.origin.x = -self.view.bounds.width
                finalLabel.frame.origin.y -= 50
                horizontalStackOfViews.frame.origin.y -= 50
                createAccountButton.alpha = 1
                loginButton.alpha = 1
            }
            switch currentIndex {
            case 0:
                progressViewOne.backgroundColor = UIColor(named: "ColorGreen")
                progressViewTwo.backgroundColor = UIColor(named: "LightGray")
                progressViewThree.backgroundColor = UIColor(named: "LightGray")
            case 1:
                progressViewTwo.backgroundColor = UIColor(named: "ColorGreen")
                progressViewOne.backgroundColor = UIColor(named: "LightGray")
                progressViewThree.backgroundColor = UIColor(named: "LightGray")
            case 2:
                progressViewOne.backgroundColor = UIColor(named: "LightGray")
                progressViewTwo.backgroundColor = UIColor(named: "LightGray")
                progressViewThree.backgroundColor = UIColor(named: "ColorGreen")
            default:
                break
            }
        }, completion: { _ in
            self.firstLabel.removeFromSuperview()
        })
    }

    private let progressViewOne = ProgressIndicatorElement()
    private let progressViewTwo = ProgressIndicatorElement()
    private let progressViewThree = ProgressIndicatorElement()

    private lazy var horizontalStackOfViews: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        stack.addArrangedSubview(progressViewOne)
        stack.addArrangedSubview(progressViewTwo)
        stack.addArrangedSubview(progressViewThree)
        return stack
    }()
    
    private let firstLabel = CustomLabel(text: "Welcome to Farmer's Market!\nGrocery Application", color: UIColor(named: "Color")!, alpha: 1.0, fontSize: 20)
    private let secondLabel = CustomLabel(text: "We provide best quality\nProducts to your family!", color: UIColor(named: "Color")!, alpha: 0.0, fontSize: 20)
    private let finalLabel = CustomLabel(text: "Fast and responsibily\ndelivery by our courir", color: UIColor(named: "Color")!, alpha: 0.0, fontSize: 20)

    private let fruitBasketPhoto = CustomImageView(image: UIImage(named: "FruitsImage")!, alpha: 1.0)
    private let deliveryGuyPhoto = CustomImageView(image: UIImage(named: "DeliveryImage")!, alpha: 0.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupButton(_ button: UIButton, _ action: Selector, _ title: String, _ color: UIColor, _ backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = color
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(fruitBasketPhoto)
        view.addSubview(firstLabel)
        view.addSubview(finalLabel)
        view.addSubview(horizontalStackOfViews)
        view.addSubview(secondLabel)
        view.addSubview(deliveryGuyPhoto)
        view.addSubview(nextButton)
        view.addSubview(createAccountButton)
        view.addSubview(loginButton)
        
        createAccountButton.alpha = 0
        loginButton.alpha = 0
        
        setupButton(nextButton, #selector(nextButtonPressed), "NEXT", .white, UIColor(named: "Color") ?? .white)
        setupButton(createAccountButton, #selector(createAccountButtonPressed), "CREATE ACCOUNT", .white, UIColor(named: "Color") ?? .white)
        setupButton(loginButton, #selector(loginButtonPressed), "LOGIN", .black, .black)
        
        loginButton.layer.borderWidth = 3.0
        loginButton.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        progressViewOne.backgroundColor = UIColor(named: "ColorGreen")
        progressViewTwo.backgroundColor = UIColor(named: "LightGray")
        progressViewThree.backgroundColor = UIColor(named: "LightGray")

        NSLayoutConstraint.activate([
            fruitBasketPhoto.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            fruitBasketPhoto.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            deliveryGuyPhoto.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            deliveryGuyPhoto.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            firstLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            firstLabel.topAnchor.constraint(equalTo: fruitBasketPhoto.bottomAnchor, constant: -100),
            
            finalLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            finalLabel.topAnchor.constraint(equalTo: fruitBasketPhoto.bottomAnchor, constant: -101),

            secondLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secondLabel.topAnchor.constraint(equalTo: fruitBasketPhoto.bottomAnchor, constant: -100),

            horizontalStackOfViews.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            horizontalStackOfViews.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -50),

            nextButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            createAccountButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
