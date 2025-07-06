//
//  ScheduleTableViewService.swift
//  Tracker
//
//  Created by R Kolos on 25.06.2025.
//

import UIKit

final class ServiceTableViewScedule: NSObject, UITableViewDelegate, UITableViewDataSource {
    let dayNames = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    var selectedDays: [WeekDay] = []
    weak var delegate: ServiceSheduleDelegate?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { dayNames.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "dayCell")
        cell.backgroundColor = .ypBackground
        
        let titleLabel = UILabel()
        titleLabel.text = dayNames[indexPath.row]
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(titleLabel)
        
        let switchView = UISwitch()
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: SetupConstants.padding),
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 75 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func switchChanged(_ sender: UISwitch!) {
        let dayIndex = sender.tag
        guard let weekDay = WeekDay(rawValue: dayIndex) else { return }
        
        if sender.isOn {
            if !selectedDays.contains(weekDay) {
                selectedDays.append(weekDay)
            }
        } else {
            selectedDays.removeAll { $0 == weekDay }
        }
        
        print("Выбранные дни: \(selectedDays)")
    }
    
    func getSelectedDays() -> [WeekDay] {
        return selectedDays
    }
}

