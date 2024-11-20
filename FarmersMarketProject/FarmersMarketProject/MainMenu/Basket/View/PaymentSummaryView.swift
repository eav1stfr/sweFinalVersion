import UIKit

final class label: UILabel {
    init(text: String, alpha: CGFloat, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.text = text
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        textColor = UIColor.gray
        numberOfLines = 1
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
    }
}


final class PaymentSummaryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let paymentSummaryLabel = label(text: "Payment Summary", alpha: 1.0)
    
    private let totalItemsLabel = label(text: "Total Items", alpha: 1.0)
    
    private let deliveryFeeLabel = label(text: "Delivery Fee", alpha: 1.0)
    
    private let discountLabel = label(text: "Discount Label", alpha: 1.0)

    private let totalLabel = label(text: "Total Payment", alpha: 1.0)
}


private extension PaymentSummaryView {
    private func setupView() {
        paymentSummaryLabel.textColor = .black
        paymentSummaryLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        layer.borderWidth = 2.0
        layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(paymentSummaryLabel)
        addSubview(totalItemsLabel)
        addSubview(deliveryFeeLabel)
        addSubview(discountLabel)
        addSubview(totalLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentSummaryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            paymentSummaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            totalItemsLabel.topAnchor.constraint(equalTo: paymentSummaryLabel.bottomAnchor, constant: 20),
            totalItemsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            deliveryFeeLabel.topAnchor.constraint(equalTo: totalItemsLabel.bottomAnchor, constant: 10),
            deliveryFeeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            discountLabel.topAnchor.constraint(equalTo: deliveryFeeLabel.bottomAnchor, constant: 10),
            discountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            totalLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 10),
            totalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
}
