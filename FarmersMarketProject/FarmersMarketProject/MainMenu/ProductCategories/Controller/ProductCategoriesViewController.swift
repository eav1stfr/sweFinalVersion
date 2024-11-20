import UIKit

final class ProductCategoriesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private let categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "CATEGORIES"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoriesCollectionView = ProductSalesView()
}

private extension ProductCategoriesViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        categoriesCollectionView.delegate = self
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        view.addSubview(categoriesLabel)
        view.addSubview(categoriesCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoriesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 63),
            categoriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 40),
            categoriesCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoriesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            categoriesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -50),
        ])
    }
}

extension ProductCategoriesViewController: ProductSalesViewDelegate{
    func categoryDidSelect() {
        print("Item was selected")
    }
}
