//
//  CustomLabel.swift
//  FarmersMarketProject
//
//  Created by Александр Эм on 18.10.2024.
//

import UIKit

class CustomLabel: UILabel {
    
    init(text: String, color: UIColor, alpha: CGFloat = 1.0, frame: CGRect = .zero, fontSize: CGFloat) {
        super.init(frame: frame)
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        self.text = text
        self.alpha = alpha
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    private func setupLabel() {
        //textColor = UIColor(named: "Color")
        numberOfLines = 2
        textAlignment = .center
        //font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//class CustomLabel: UILabel {
//    var textOfLabel: String? {
//        didSet {
//            super.text = textOfLabel
//        }
//    }
//
//    var textColorOfLabel: UIColor? {
//        didSet {
//            super.textColor = textColorOfLabel
//        }
//    }
//
//    var alphaOfLabel: CGFloat = 1.0 {
//        didSet {
//            super.alpha = alphaOfLabel
//        }
//    }
//
//    var fontSize: CGFloat? {
//        didSet {
//            super.font = UIFont.systemFont(ofSize: fontSize ?? 20, weight: .heavy)
//        }
//    }
//
//    override init(frame: CGRect = .zero) {
//        super.init(frame: frame)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupCustomLabel() {
//        numberOfLines = 2
//        textAlignment = .center
//        translatesAutoresizingMaskIntoConstraints = false
//    }
//}
