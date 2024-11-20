import UIKit

protocol ShippingAddressViewDelegate: AnyObject {
    func nextButtonPressed()
    func saveShippingAddressButtonPressed()
    func endEditing()
}

final class ShippingAddressView: UIView {
    
    weak var delegate: ShippingAddressViewDelegate?
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = false
        return scrollView
    }()
    
    private let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let nextButton = CustomButton()
    
    
    private let fullNameTextField = TextFieldView(placeH: "Full Name", width: 300)
    private let fullNameLabel = CustomLabel(text: "Full Name", color: .black, fontSize: 16)
    
    private let emailAddressTextField = TextFieldView(placeH: "alexandr.em@nu.edu.kz", width: 300)
    private let emailAddressLabel = CustomLabel(text: "Email Address", color: .black, fontSize: 16)
    
    private let phoneNumberTextField = TextFieldView(placeH: "+7-777-111-34-77", width: 300)
    private let phoneNumberLabel = CustomLabel(text: "Phone Number", color: .black, fontSize: 16)
    
    private let addressTextField = TextFieldView(placeH: "Type your home address", width: 300)
    private let addressLabel = CustomLabel(text: "Address", color: .black, fontSize: 16)
    
    private let zipTextField = TextFieldView(placeH: "Enter ZIP", width: 150)
    private let zipLabel = CustomLabel(text: "Zip Code", color: .black, fontSize: 16)
    
    private let cityTextField = TextFieldView(placeH: "e.g., Astana", width: 150)
    private let cityLabel = CustomLabel(text: "City", color: .black, fontSize: 16)
    
    private let countryLabel = CustomLabel(text: "Country", color: .black, fontSize: 16)
    private let countryTextField = TextFieldView(placeH: "Kazakhstan", width: 300)
    
    private let saveShippingAddressLabel = CustomLabel(text: "Save Shipping Address", color: .black, fontSize: 16)
    
    internal lazy var saveCheckbox: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor(named: "Color")?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackForSaveShippingAddress: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.addArrangedSubview(saveCheckbox)
        stack.addArrangedSubview(saveShippingAddressLabel)
        return stack
    }()
    
    
    private lazy var stackForZipCode: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(zipLabel)
        stack.addArrangedSubview(zipTextField)
        return stack
    }()
    
    private lazy var stackForCity: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(cityLabel)
        stack.addArrangedSubview(cityTextField)
        return stack
    }()
    
    private lazy var stackOfStacks: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(stackForZipCode)
        stack.addArrangedSubview(stackForCity)
        return stack
    }()
    
    @objc private func savePressed() {
        delegate?.saveShippingAddressButtonPressed()
    }
    
    @objc private func nextButtonPressed() {
        delegate?.nextButtonPressed()
    }
}

private extension ShippingAddressView {
    private func setupView() {
        backgroundColor = .white
        addSubviews()
        setupConstraints()
        
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.titleLabel?.textColor = .black
        nextButton.backgroundColor = UIColor(named: "Color")
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addGestureRecognizer(tap)
        
        addSubview(scrollView)
        
        scrollView.addSubview(mainContentView)
        
        mainContentView.addSubview(fullNameLabel)
        mainContentView.addSubview(fullNameTextField)
        
        mainContentView.addSubview(emailAddressLabel)
        mainContentView.addSubview(emailAddressTextField)
        
        mainContentView.addSubview(phoneNumberLabel)
        mainContentView.addSubview(phoneNumberTextField)
        
        mainContentView.addSubview(addressLabel)
        mainContentView.addSubview(addressTextField)
        
        mainContentView.addSubview(stackOfStacks)
        
        mainContentView.addSubview(countryLabel)
        mainContentView.addSubview(countryTextField)
        
        mainContentView.addSubview(stackForSaveShippingAddress)
        
        mainContentView.addSubview(nextButton)
        
        mainContentView.backgroundColor = .white
        
        mainContentView.addSubview(emptyView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            mainContentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height + 50),
            mainContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainContentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 20),
            fullNameLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            fullNameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 15),
            fullNameTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            emailAddressLabel.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 20),
            emailAddressLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            emailAddressTextField.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor, constant: 15),
            emailAddressTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            
            phoneNumberLabel.topAnchor.constraint(equalTo: emailAddressTextField.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 15),
            phoneNumberTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            
            addressLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            addressTextField.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15),
            addressTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            stackOfStacks.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 40),
            stackOfStacks.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            
            countryLabel.topAnchor.constraint(equalTo: stackOfStacks.bottomAnchor, constant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            countryTextField.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 15),
            countryTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            stackForSaveShippingAddress.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 20),
            stackForSaveShippingAddress.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            
            nextButton.topAnchor.constraint(equalTo: stackForSaveShippingAddress.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            emptyView.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 5),
            emptyView.heightAnchor.constraint(equalToConstant: 50),
            emptyView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor)
        ])
    }
}
