import UIKit

final class BasketViewController: UIViewController {
    
    private let paymentView = PaymentSummaryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

private extension BasketViewController {
    
    private func setupView() {
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(paymentView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            paymentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            paymentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            paymentView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
}
