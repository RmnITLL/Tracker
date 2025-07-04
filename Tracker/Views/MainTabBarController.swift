//
//  TabBarController.swift
//  Tracker
//
//  Created by R Kolos on 24.06.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.tabBar.tintColor = .ypBlue
        self.tabBar.barTintColor = .ypWhite
        self.tabBar.unselectedItemTintColor = .ypGray
    }
    
    // MARK: - Methods
    private func setupTabs() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        let datePickerItem = UIBarButtonItem(customView: datePicker)
        
        let trackersViewController = self.setupNav(
            title: "Трекеры",
            image: .trackers,
            leftButtonItem: UIBarButtonItem(image: .trackerPlus, style: .plain, target: nil, action: #selector(addTrackerButtonTapped)),
            rightButtonItem: datePickerItem,
            vc: TrackersViewController()
        )
        
        let statisticsViewController = self.setupNav(
            title: "Статистика",
            image: .hare,
            leftButtonItem: nil,
            rightButtonItem: nil,
            vc: StatisticsViewController()
        )
        self.setViewControllers([trackersViewController, statisticsViewController], animated: true)
    }
    
    private func setupNav(title: String, image: UIImage, leftButtonItem: UIBarButtonItem?, rightButtonItem: UIBarButtonItem?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        nav.viewControllers.first?.navigationItem.leftBarButtonItem = leftButtonItem
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = rightButtonItem
        nav.viewControllers.first?.navigationItem.leftBarButtonItem?.tintColor = .ypBlack
        nav.viewControllers.first?.navigationItem.rightBarButtonItem?.tintColor = .ypBlack
        return nav
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        TrackersCollection.shared.currentDate = sender.date
        TrackersCollection.shared.reload()
    }
    
    @objc private func addTrackerButtonTapped() {
        let trackerTypeVC = TrackerTypeViewController()
        present(trackerTypeVC, animated: true)
    }
}
