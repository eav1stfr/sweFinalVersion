import UIKit

protocol ProductSalesViewDelegate: AnyObject {
    func categoryDidSelect()
}

final class ProductSalesView: UIView {
    
    weak var delegate: ProductSalesViewDelegate?
    
    private let cellsInfo: [ProductCategoriesModel] = [
        ProductCategoriesModel(imageName: "Fruits", nameOfCategory: "Fruits"),
        ProductCategoriesModel(imageName: "Vegetables", nameOfCategory: "Vegetables"),
        ProductCategoriesModel(imageName: "Mushrooms", nameOfCategory: "Mushrooms"),
        ProductCategoriesModel(imageName: "Dairy", nameOfCategory: "Dairy"),
        ProductCategoriesModel(imageName: "Oats", nameOfCategory: "Oats"),
        ProductCategoriesModel(imageName: "Bread", nameOfCategory: "Bread")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}


private extension ProductSalesView {
    private func setupView() {
        addSubviews()
        setupConstraints()
        addSubviewsStyle()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func addSubviewsStyle() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
    }
}

extension ProductSalesView: UICollectionViewDelegateFlowLayout {
    //size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    //vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension ProductSalesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.categoryDidSelect()
    }
}

extension ProductSalesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier,
            for: indexPath
        ) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.set(cell: cellsInfo[indexPath.row])
        
        return cell
    }
}
