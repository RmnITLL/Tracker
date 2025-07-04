//
//  NewTrackerViewController.swift
//  Tracker
//
//  Created by R Kolos on 25.06.2025.
//

import UIKit

final class NewTrackerViewController: UIViewController, ServiceSheduleDelegate {
    // MARK: - Properties
    var titleName: String
    var schedule: Array<WeekDay> = []
    
    private let scrollView = UIScrollView()
    private let vStackView = UIStackView()
    private let hStackView = UIStackView()
    private let tableView = UITableView()
    private var tableViewService: NewCategotyButton?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let trackerNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название трекера"
        textField.backgroundColor = .ypBackground
        textField.layer.cornerRadius = SetupConstants.cornerRadius
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textfieldChanged(_:)), for: .editingChanged)
        
        return textField
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.ypRed, for: .normal)
        button.backgroundColor = .ypWhite
        button.tintColor = .ypRed
        button.layer.borderColor = UIColor.ypRed.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = SetupConstants.cornerRadius
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.ypWhite, for: .normal)
        button.backgroundColor = .ypGray
        button.layer.cornerRadius = SetupConstants.cornerRadius
        button.isEnabled = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .currentContext
        view.backgroundColor = .ypWhite
        titleLabel.text = titleName
        tableViewService = NewCategotyButton(chosenType: titleName)
        tableView.delegate = tableViewService
        tableView.dataSource = tableViewService
        tableViewService?.viewController = self
        
        setupTitleLabel()
        setupScrollView()
        setupHStackView()
        setupVStackView()
        setupAndAddElements()
    }
    
    // MARK: - Methods
    private func setupTitleLabel() {
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 241),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -76),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupVStackView() {
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 30
        scrollView.addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -SetupConstants.padding),
            vStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: SetupConstants.padding),
            vStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }
    
    private func setupHStackView() {
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.spacing = 8
        view.addSubview(hStackView)
        
        NSLayoutConstraint.activate([
            hStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: SetupConstants.padding),
            hStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            hStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupAndAddElements() {
        tableView.backgroundColor = .ypBackground
        tableView.layer.cornerRadius = SetupConstants.cornerRadius
        
        switch titleName {
        case "Новая привычка":
            tableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        case "Новое нерегулярное событие":
            tableView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        default: return
        }
        vStackView.addArrangedSubview(trackerNameTextField)
        vStackView.addArrangedSubview(tableView)
        
        hStackView.addArrangedSubview(cancelButton)
        hStackView.addArrangedSubview(createButton)
        
        NSLayoutConstraint.activate([
            trackerNameTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            trackerNameTextField.heightAnchor.constraint(equalToConstant: 75),
            tableView.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
        ])
    }
    
    @objc private func textfieldChanged(_ sender: UITextField) {
        if let text = sender.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            createButton.isEnabled = true
            createButton.backgroundColor = .ypBlack
        } else {
            createButton.isEnabled = false
            createButton.backgroundColor = .ypGray
        }
    }
    
    func didSelectSchedule(days: [WeekDay]) {
        self.schedule = days
        print("Получены выбранные дни: \(days)")
    }
    
    func openScheduleController() {
        trackerNameTextField.resignFirstResponder()
        let scheduleVC = ScheduleViewController()
        scheduleVC.delegate = self
        present(scheduleVC, animated: true)
    }
    
    @objc private func createButtonTapped() {
        guard let trackerName = trackerNameTextField.text, !trackerName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Ошибка: Имя трекера не может быть пустым")
            return
        }
        
        let newTracker = Tracker(
            id: UUID(),
            nameTrackers: trackerNameTextField.text!,
            colorTrackers: .selection14,
            emojiTrackers: "🥸",
            scheduleTrackers: schedule
        )
        
        if let firstCategory = TrackersCollection.shared.categories.first {
            TrackersCollection.shared.addTracker(newTracker, toCategoryWithTitle: firstCategory.title)
        } else {
            TrackersCollection.shared.addTracker(newTracker, toCategoryWithTitle: "Домашний уют")
        }
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

