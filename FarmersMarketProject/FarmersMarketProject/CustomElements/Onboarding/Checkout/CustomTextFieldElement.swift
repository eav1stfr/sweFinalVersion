import UIKit

final class TextFieldView: UITextField {
    
    private var widthConstraint: NSLayoutConstraint?
    
    init(frame: CGRect = .zero, placeH: String, width: CGFloat) {
        super.init(frame: frame)
        self.placeholder = placeH
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        backgroundColor = .white
        layer.cornerRadius = 30
        layer.borderWidth = 1.0
        
        layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 60))
        rightViewMode = .always
        leftViewMode = .always
        textColor = .black
        
        autocapitalizationType = .none
        
        tintColor = .black
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}
