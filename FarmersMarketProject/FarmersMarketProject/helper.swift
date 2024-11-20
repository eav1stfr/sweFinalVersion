//import UIKit
//
//protocol MentorInfoListViewDelegate: AnyObject {
//    func mentorInfoListViewDidSelect(mentor: MentorModel)
//}
//
//final class MentorInfoListView: UIView {
//    weak var delegate: MentorInfoListViewDelegate?
//
//    private let tableView = UITableView()
//    private var mentorsList: [MentorModel] = []
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(mentorsList: [MentorModel]) {
//        self.mentorsList = mentorsList
//        tableView.reloadData()
//    }
//
//    func update(mentor: MentorModel) {
//        guard let mentorIndex = mentorsList.firstIndex(where: {$0.name==mentor.name}) else {
//            return
//        }
//        mentorsList[mentorIndex] = mentor
//        tableView.reloadData()
//    }
//}
//
//extension MentorInfoListView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mentorsList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let mentorCell = tableView.dequeueReusableCell(
//            withIdentifier: "MentorCustomCell",
//            for: indexPath
//        ) as? MentorCustomCell else {
//            return UITableViewCell()
//        }
//        mentorCell.set(mentor: mentorsList[indexPath.row])
//        return mentorCell
//    }
//}
//
//extension MentorInfoListView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        delegate?.mentorInfoListViewDidSelect(mentor: mentorsList[indexPath.row])
//    }
//}
//
//private extension MentorInfoListView {
//    private func setupView() {
//        addSubviews()
//        setupSubviewsConstraints()
//        addSubviewsStyles()
//    }
//
//    private func addSubviews() {
//        addSubview(tableView)
//    }
//
//    private func setupSubviewsConstraints() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.rowHeight = 80
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    private func addSubviewsStyles() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(MentorCustomCell.self, forCellReuseIdentifier: "MentorCustomCell")
//    }
//}
//
//
//
//import UIKit
//
//final class MentorCustomCell: UITableViewCell {
//
//    private lazy var circle: UIView = {
//        let view = UIView()
//        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        view.layer.cornerRadius = 25
//        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(firstCharLabel)
//        return view
//    }()
//
//    private let mentorNameLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 30)
//        return label
//    }()
//
//
//    private var circleBackgroundColor = UIColor()
//
//    private let firstCharLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
//        label.textColor = .white
//        return label
//    }()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(circle)
//        addSubview(mentorNameLabel)
//        setLabelConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func set(mentor: MentorModel) {
//        mentorNameLabel.text = mentor.name
//        circleBackgroundColor = mentor.backgroundColor
//        firstCharLabel.text = String(mentor.firstChar)
//        circle.backgroundColor = mentor.backgroundColor
//        firstCharLabel.text = String(mentor.firstChar)
//    }
//
//    private func setLabelConstraints() {
//        NSLayoutConstraint.activate([
//            firstCharLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
//            firstCharLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
//
//            circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
//
//            mentorNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            mentorNameLabel.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 15),
//            mentorNameLabel.heightAnchor.constraint(equalToConstant: 80),
//            mentorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
//        ])
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//}
//
//
//// MARK: - view controller
//
//import UIKit
//
//final class MainViewController: UIViewController {
//
//    private let table = MentorInfoListView()
//
//    private let mentorsList: [MentorModel] = [
//        MentorModel(name: "Amirzhan", firstChar: "A", backgroundColor: .blue),
//        MentorModel(name: "Alisher", firstChar: "A", backgroundColor: .green),
//        MentorModel(name: "Yersin", firstChar: "Y", backgroundColor: .orange),
//        MentorModel(name: "Yedige", firstChar: "Y", backgroundColor: .purple),
//        MentorModel(name: "Abrorbek", firstChar: "A", backgroundColor: .systemMint),
//        MentorModel(name: "Medeo", firstChar: "M", backgroundColor: .systemRed)
//    ]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Mentors"
//        table.delegate = self
//        setupView()
//    }
//}
//
//extension MainViewController: MentorInfoListViewDelegate {
//    func mentorInfoListViewDidSelect(mentor: MentorModel) {
//        let detailsViewController = MentorDetailsViewViewController(mentor: mentor)
//        detailsViewController.delegate = self
//        navigationController?.pushViewController(detailsViewController, animated: true)
//    }
//}
//
//extension MainViewController: MentorDetailsViewDelegate {
//    func update(mentor: MentorModel) {
//        table.update(mentor: mentor)
//    }
//}
//
//private extension MainViewController {
//    private func setupView() {
//        view.backgroundColor = .white
//        addSubviews()
//        setupConstraints()
//    }
//
//    private func addSubviews() {
//        view.addSubview(table)
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.configure(mentorsList: mentorsList)
//    }
//
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            table.topAnchor.constraint(equalTo: view.topAnchor),
//            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//}
//
