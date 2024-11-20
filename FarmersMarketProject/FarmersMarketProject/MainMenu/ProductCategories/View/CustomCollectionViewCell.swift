import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "CustomCollectionViewCell"
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 50).isActive = true
        image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "Color")!
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    

    func configure() {
        
    }
    
    func set(cell: ProductCategoriesModel) {
        setupView()
        self.backgroundColor = .systemGray6
        layer.cornerRadius = 20
        self.categoryName.text = cell.nameOfCategory
        self.image.image = UIImage(named: cell.imageName)!
    }
}

private extension CustomCollectionViewCell {
    
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(image)
        addSubview(categoryName)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            categoryName.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2),
            categoryName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
