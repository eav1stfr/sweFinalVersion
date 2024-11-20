import UIKit

protocol ProfileViewDelegate: AnyObject {
    func profileOptionViewDidSelect()
}

final class ProfileView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ProfileViewDelegate?
    
    private let tableView = UITableView()
    
    private var tableCells: [TableCellModel] = []
    
}

extension ProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customCell = tableView.dequeueReusableCell(
            withIdentifier: "TableViewCustomCell",
            for: indexPath
        ) as? TableViewCustomCell else {
            return UITableViewCell()
        }
        customCell.set(cell: tableCells[indexPath.row])
        return customCell
    }
    
}

extension ProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.profileOptionViewDidSelect()
    }
}

extension ProfileView {
    func configure(cellList: [TableCellModel]) {
        self.tableCells = cellList
        
        tableView.reloadData()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setupConstraints()
        addSubviewsStyle()
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addSubviewsStyle() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCustomCell.self, forCellReuseIdentifier: "TableViewCustomCell")
    }
}
