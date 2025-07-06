//
//  ButtonsTableViewService.swift
//  Tracker
//
//  Created by R Kolos on 25.06.2025.
//

import UIKit

final class NewCategoryButton: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let trackerButtonsTexts = ["Категория", "Расписание"]
    let irregularActionButtonTexts = ["Категория"]
    var chosenType: String
    weak var viewController: NewTrackerViewController?

    init(chosenType: String) {
        self.chosenType = chosenType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch chosenType {
        case "Новая привычка":
            return trackerButtonsTexts.count
        case "Новое нерегулярное событие":
            return irregularActionButtonTexts.count
        default: return 0
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: SetupConstants.categoryCellIdentifier)
        cell.backgroundColor = .ypBackground
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = trackerButtonsTexts[indexPath.row]
        
        let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        chevronImageView.tintColor = .ypGray
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.addSubview(chevronImageView)
        cell.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: SetupConstants.padding),
            titleLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -22),
            chevronImageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 75 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            return
        case 1:
            viewController?.openScheduleController()
        default: return
        }
    }
}
