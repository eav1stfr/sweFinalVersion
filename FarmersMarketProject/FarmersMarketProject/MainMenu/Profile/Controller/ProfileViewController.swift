import UIKit

final class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private let defaults = UserDefaults.standard
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "PROFILE"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profilePhoto: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(named: "photo")!
        photo.contentMode = .scaleAspectFit
        photo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        photo.layer.cornerRadius = 50
        photo.layer.masksToBounds = false
        photo.clipsToBounds = true
        return photo
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = (defaults.string(forKey: "Name") ?? "Alexandr")+" "+(defaults.string(forKey: "Surname") ?? "Em")
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = defaults.string(forKey: "Email")
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackForLabels: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        stack.spacing = 10
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(emailLabel)
        return stack
    }()
    
    private lazy var stackForUpperView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(profilePhoto)
        stack.addArrangedSubview(stackForLabels)
        stack.backgroundColor = .white
        return stack
    }()
    
    private let table = ProfileView()
    
    private let customCells: [TableCellModel] = [
        TableCellModel(imageName: "pencil.line", description: "Edit Personal Information"),
        TableCellModel(imageName: "pencil.line", description: "Edit App Mode"),
        TableCellModel(imageName: "basket.fill", description: "Order History"),
        TableCellModel(imageName: "lock.fill", description: "Change Password"),
        TableCellModel(imageName: "door.left.hand.open", description: "Log Out")
    ]
    
}

extension ProfileViewController: ProfileViewDelegate {
    func profileOptionViewDidSelect() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "IsAuthorized")
        print("pressed")
    }
}

private extension ProfileViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        table.delegate = self
        addSubviews()
        setupConstraints()
        table.configure(cellList: customCells)
    }
    
    private func addSubviews() {
        view.addSubview(profileLabel)
        view.addSubview(stackForUpperView)
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 63),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            stackForUpperView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 20),
            stackForUpperView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            table.topAnchor.constraint(equalTo: stackForUpperView.bottomAnchor, constant: 30),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
