import UIKit

protocol PaymentMethodViewDelegate: AnyObject {
    func creditCardPaymentOptionChosen()
    func cashPaymentOptionChosen()
    func bonusesPaymentOptionChosen()
    func confirmOrderButton()
}

final class PaymentMethodView: UIView {
    
    weak var delegate: PaymentMethodViewDelegate?
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let MainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.isScrollEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var horizontalStackOfOptions: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.backgroundColor = .white
        return stack
    }()
    
    private let confirmOrderButton = CustomButton()
    
    private let creditCardButton = CustomButton()
    private let cashOnDeliveryButton = CustomButton()
    private let bonusesPaymentOptionButton = CustomButton()
    
    private let cardHolderNameLabel = CustomLabel(text: "Card Holder Name", color: .black, fontSize: 16)
    private let cardHolderNameTextField = TextFieldView(placeH: "Alexandr Em", width: 300)
    
    private let cardNumberLabel = CustomLabel(text: "Card Number", color: .black, fontSize: 16)
    private let cardNumberTextField = TextFieldView(placeH: "7777 7777 7777 7777", width: 300)
    
    private let monthYearLabel = CustomLabel(text: "Month / Year", color: .black, fontSize: 16)
    private let monthYearTextField = TextFieldView(placeH: "month / year", width: 150)
    
    private let cvvLabel = CustomLabel(text: "CVV", color: .black, fontSize: 16)
    private let cvvTextField = TextFieldView(placeH: "CVV", width: 150)
    
    private let countryLabel = CustomLabel(text: "Country", color: .black, fontSize: 16)
    private let countryTextField = TextFieldView(placeH: "Kazakhstan", width: 300)
    
    private lazy var stackForMonthYear: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(monthYearLabel)
        stack.addArrangedSubview(monthYearTextField)
        return stack
    }()
    
    private lazy var stackForCVV: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(cvvLabel)
        stack.addArrangedSubview(cvvTextField)
        return stack
    }()
    
    private lazy var stackOfStacks: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(stackForMonthYear)
        stack.addArrangedSubview(stackForCVV)
        return stack
    }()
}

private extension PaymentMethodView {
    private func setupView() {
        creditCardButton.tag = 1
        cashOnDeliveryButton.tag = 2
        bonusesPaymentOptionButton.tag = 3
        
        setupButton(confirmOrderButton, #selector(confirmOrderButtonPressed), "CONFIRM ORDER", .white, UIColor(named: "Color")!, 300)
        
        setupButton(creditCardButton, #selector(buttonPressed), "Card", .black, .white, 150)
        setupButton(cashOnDeliveryButton, #selector(buttonPressed), "Cash", .black, .white, 150)
        setupButton(bonusesPaymentOptionButton, #selector(buttonPressed), "Bonuses", .black, .white, 150)

        
        addSubviews()
        setupConstraints()
    }
    
    @objc private func confirmOrderButtonPressed() {
        delegate?.confirmOrderButton()
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        switch (sender.tag) {
        case 1:
            creditCardButton.backgroundColor = UIColor(named: "Color")
            cashOnDeliveryButton.backgroundColor = .white
            bonusesPaymentOptionButton.backgroundColor = .white
            delegate?.creditCardPaymentOptionChosen()
        case 2:
            creditCardButton.backgroundColor = .white
            cashOnDeliveryButton.backgroundColor = UIColor(named: "Color")
            bonusesPaymentOptionButton.backgroundColor = .white
            delegate?.cashPaymentOptionChosen()
        case 3:
            creditCardButton.backgroundColor = .white
            cashOnDeliveryButton.backgroundColor = .white
            bonusesPaymentOptionButton.backgroundColor = UIColor(named: "Color")
            delegate?.bonusesPaymentOptionChosen()
        default:
            break
        }
    }
    
    private func addSubviews() {
        addGestureRecognizer(tap)
        addSubview(MainScrollView)
        
        MainScrollView.addSubview(mainContentView)
        
        mainContentView.addSubview(horizontalScrollView)
        
        horizontalScrollView.addSubview(horizontalStackOfOptions)
        
        horizontalStackOfOptions.addArrangedSubview(creditCardButton)
        horizontalStackOfOptions.addArrangedSubview(cashOnDeliveryButton)
        horizontalStackOfOptions.addArrangedSubview(bonusesPaymentOptionButton)
        
        mainContentView.addSubview(cardHolderNameLabel)
        mainContentView.addSubview(cardHolderNameTextField)

        mainContentView.addSubview(cardNumberLabel)
        mainContentView.addSubview(cardNumberTextField)
        
        mainContentView.addSubview(stackOfStacks)
        
        mainContentView.addSubview(countryLabel)
        mainContentView.addSubview(countryTextField)
        
        mainContentView.addSubview(confirmOrderButton)
    }
    
    private func setupButton(_ button: UIButton, _ action: Selector, _ title: String, _ color: UIColor, _ backgroundColor: UIColor, _ width: CGFloat) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: action, for: .touchUpInside)
        button.layer.borderColor = UIColor(named: "Color")?.cgColor
        button.layer.borderWidth = 3.0
        button.widthAnchor.constraint(equalToConstant: width).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            MainScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            MainScrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            MainScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            MainScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            MainScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
 
            mainContentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            mainContentView.topAnchor.constraint(equalTo: MainScrollView.topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: MainScrollView.leadingAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: MainScrollView.trailingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: MainScrollView.bottomAnchor),
            mainContentView.centerXAnchor.constraint(equalTo: MainScrollView.centerXAnchor),
            
            horizontalScrollView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 20),
            horizontalScrollView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 20),
            horizontalScrollView.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor),
            horizontalScrollView.heightAnchor.constraint(equalToConstant: 60),
            
            horizontalStackOfOptions.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            horizontalStackOfOptions.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            horizontalStackOfOptions.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor),
            horizontalStackOfOptions.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor),
                        
            
            cardHolderNameLabel.topAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor, constant: 20), //20
            cardHolderNameLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            cardHolderNameTextField.topAnchor.constraint(equalTo: cardHolderNameLabel.bottomAnchor, constant: 15),
            cardHolderNameTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            cardNumberLabel.topAnchor.constraint(equalTo: cardHolderNameTextField.bottomAnchor, constant: 20),
            cardNumberLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            cardNumberTextField.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 15),
            cardNumberTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            stackOfStacks.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 40),
            stackOfStacks.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 20),
            
            countryLabel.topAnchor.constraint(equalTo: stackOfStacks.bottomAnchor, constant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 35),
            
            countryTextField.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 15),
            countryTextField.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            
            confirmOrderButton.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 40),
            confirmOrderButton.centerXAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            confirmOrderButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
