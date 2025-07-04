//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by R Kolos on 25.06.2025.
//

import UIKit

final class ScheduleViewController: UIViewController {
    
    weak var delegate: ServiceSheduleDelegate?
    
    let tableView = UITableView()
    let scheduleTableViewService = ServiceTableViewScedule()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Расписание"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .ypBlack
        button.layer.cornerRadius = SetupConstants.cornerRadius
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .currentContext
        view.backgroundColor = .ypWhite
        
        tableView.delegate = scheduleTableViewService
        tableView.dataSource = scheduleTableViewService
        
        setupViewsAndActivateConstraints()
    }
    
    private func setupViewsAndActivateConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = SetupConstants.cornerRadius
        tableView.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(SetupConstants.padding * 2)),
            tableView.heightAnchor.constraint(equalToConstant: 525),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50),
            doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            doneButton.heightAnchor.constraint(equalToConstant: SetupConstants.heightButtons),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SetupConstants.padding)
        ])
    }
    
    @objc private func doneButtonTapped() {
        let selectedDays = scheduleTableViewService.getSelectedDays()
        print("selectedDays: \(selectedDays)")
        delegate?.didSelectSchedule(days: selectedDays)
        dismiss(animated: true)
    }
}

