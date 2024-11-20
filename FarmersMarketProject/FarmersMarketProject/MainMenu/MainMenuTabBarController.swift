import UIKit

final class MainMenuTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
        setupView()
    }
}

extension MainMenuTabBarController {
    private func configureTabs() {
        let productCategoriesVC = ProductCategoriesViewController()
        let trackOrderVC = CheckoutViewController()
        let profileVC = ProfileViewController()
        let basketVC = BasketViewController()
        
        productCategoriesVC.tabBarItem.image = UIImage(systemName: "house.fill")
        productCategoriesVC.tabBarItem.image?.withTintColor(.black)
        productCategoriesVC.tabBarItem.title = "Products"
        
        trackOrderVC.tabBarItem.image = UIImage(systemName: "arrow.left.arrow.right")
        trackOrderVC.tabBarItem.image?.withTintColor(.black)
        trackOrderVC.tabBarItem.title = "Track Order"
        
        profileVC.tabBarItem.image = UIImage(systemName: "person.fill")
        profileVC.tabBarItem.image?.withTintColor(.black)
        profileVC.tabBarItem.badgeColor = .black
        profileVC.tabBarItem.title = "Profile"
        
        basketVC.tabBarItem.image = UIImage(systemName: "basket.fill")
        basketVC.tabBarItem.image?.withTintColor(.black)
        basketVC.tabBarItem.badgeColor = .black
        basketVC.tabBarItem.title = "Basket"

        let nav1 = UINavigationController(rootViewController: productCategoriesVC)
        let nav2 = UINavigationController(rootViewController: trackOrderVC)
        let nav3 = UINavigationController(rootViewController: profileVC)
        let nav4 = UINavigationController(rootViewController: basketVC)
        
        tabBar.tintColor = UIColor(named: "Color")!
        tabBar.backgroundColor = .systemGray6
        
        setViewControllers([nav1, nav2, nav4, nav3], animated: true)
    }
}

private extension MainMenuTabBarController {
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}
