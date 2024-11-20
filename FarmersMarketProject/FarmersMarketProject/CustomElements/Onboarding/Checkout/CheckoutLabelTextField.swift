import UIKit

final class CheckoutTextFieldLabel: UILabel {
    init(text: String, alpha: CGFloat, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        textColor = UIColor.black
        numberOfLines = 1
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
