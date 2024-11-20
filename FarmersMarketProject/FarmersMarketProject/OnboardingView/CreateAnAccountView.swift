
import Foundation
import UIKit

final class CreateAnAccountView: UIViewController {
    //MARK: - REGULAR VARS
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    //MARK: - VIEWS
    private lazy var stackOfButton: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.backgroundColor = .white
        stack.addArrangedSubview(farmerButtonCustom)
        stack.addArrangedSubview(buyerButtonCustom)
        return stack
    }()
    
    private let deliveryPhoto = CustomImageView(image: UIImage(named: "DeliveryImage")!, alpha: 1.0)
    
    //MARK: - BUTTONS
    private let farmerButtonCustom = CustomButton()
    private let buyerButtonCustom = CustomButton()
    
    //MARK: - FUNCTIONS
    @objc private func farmerButtonPressed() {
        
    }
    
    @objc private func buyerButtonPressed() {
        let newVC = CreateAccountViewController()
        newVC.modalPresentationStyle = .fullScreen
        self.present(newVC, animated: true, completion: nil )
    }
    
    private func setupButton(_ button: UIButton, _ action: Selector, _ title: String, _ color: UIColor, _ backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = color
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(deliveryPhoto)
        view.addSubview(stackOfButton)
        view.addSubview(label)
        
        setupButton(farmerButtonCustom, #selector(farmerButtonPressed), "FARMER", .white, UIColor(named: "Color") ?? .white)
        setupButton(buyerButtonCustom, #selector(buyerButtonPressed), "BUYER", .black, .black)
        buyerButtonCustom.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        buyerButtonCustom.layer.borderWidth = 3.0
        
        NSLayoutConstraint.activate([
            deliveryPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deliveryPhoto.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: stackOfButton.topAnchor, constant: -50),
            
            stackOfButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackOfButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}
