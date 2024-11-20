import UIKit

final class CheckoutViewController: UIViewController {
 
    private let shippingAddressView = ShippingAddressView()
    private let paymentMethodView = PaymentMethodView()
    private var shippingAddressViewLeadingConstraint: NSLayoutConstraint!
    private var paymentMethodViewLeadingConstraint: NSLayoutConstraint!
    
    private let checkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "CHECKOUT"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainContentView = UIView()
    
    private var buttonPressedIndicator: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        shippingAddressView.delegate = self
        shippingAddressView.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodView.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
        paymentMethodView.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(checkoutLabel)
        self.view.addSubview(shippingAddressView)
        self.view.addSubview(paymentMethodView)
    }
    
    private func setupConstraints() {
        shippingAddressViewLeadingConstraint = shippingAddressView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        paymentMethodViewLeadingConstraint = paymentMethodView.leadingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([
            checkoutLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            checkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            shippingAddressViewLeadingConstraint,
            shippingAddressView.topAnchor.constraint(equalTo: checkoutLabel.bottomAnchor, constant: 10),
            shippingAddressView.widthAnchor.constraint(equalTo: view.widthAnchor),
            shippingAddressView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            paymentMethodViewLeadingConstraint,
            paymentMethodView.topAnchor.constraint(equalTo: checkoutLabel.bottomAnchor, constant: 10),
            paymentMethodView.widthAnchor.constraint(equalTo: view.widthAnchor),
            paymentMethodView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

extension CheckoutViewController: ShippingAddressViewDelegate {
    func saveShippingAddressButtonPressed() {
        print("save button pressed")
        if !buttonPressedIndicator {
            shippingAddressView.saveCheckbox.backgroundColor = UIColor(named: "Color")
        } else {
            shippingAddressView.saveCheckbox.backgroundColor = .white
        }
        buttonPressedIndicator.toggle()
    }
    
    func nextButtonPressed() {
        shippingAddressViewLeadingConstraint.constant = -view.bounds.width
        paymentMethodViewLeadingConstraint.constant -= view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {[self] in
            view.layoutIfNeeded()
        }, completion: {_ in
            self.shippingAddressView.removeFromSuperview()
        })
    }
    
    func endEditing() {
        
    }
}

extension CheckoutViewController: PaymentMethodViewDelegate {
    func confirmOrderButton() {
        print("Confirm order button pressed")
    }
    
    func creditCardPaymentOptionChosen() {
        
    }
    
    func cashPaymentOptionChosen() {
        
    }
    
    func bonusesPaymentOptionChosen() {
        
    }
}
