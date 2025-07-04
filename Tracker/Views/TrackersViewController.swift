//
//  TrackersViewController.swift
//  Tracker
//
//  Created by R Kolos on 24.06.2025.
//

import UIKit

final class TrackersViewController: UIViewController {
    // MARK: - Properties
    var currentDate: Date?
    let trackersCollectionService = TrackersCollection.shared
    
    private lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Поиск"
        textField.backgroundColor = UIColor(cgColor: CGColor(red: 118/255, green: 118/255, blue: 128/255, alpha: 0.12))
        textField.layer.cornerRadius = 10
        
        let imageView = UIImageView(image: UIImage.magnifyingglass)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: textField.frame.height))
        imageView.frame = CGRect(x: 10, y: -7, width: 15, height: 15)
        imageView.contentMode = .scaleAspectFit
        paddingView.addSubview(imageView)
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var starImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage.star
        view.image = image
        return view
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    lazy var trackersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        trackersCollectionService.viewController = self
        trackersCollectionService.currentDate = Date()
        trackersCollectionService.reload()
        
        if trackersCollectionService.categories[0].trackers.isEmpty {
            hideCollection()
        } else {
            showCollection()
        }
        
        if trackersCollectionService.categories[0].trackers.isEmpty {
            trackersCollectionView.isHidden = true
        }
        trackersCollectionView.delegate = trackersCollectionService
        trackersCollectionView.dataSource = trackersCollectionService
        trackersCollectionView.register(CellTracker.self, forCellWithReuseIdentifier: SetupConstants.trackerCellIdentifier)
        trackersCollectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SetupConstants.headerIdentifier
        )
        
        loadViews()
        loadConstraints()
    }
    
    func hideCollection() {
        trackersCollectionView.isHidden = true
    }
    
    func showCollection() {
        trackersCollectionView.isHidden = false
    }
    
    private func loadViews() {
        view.backgroundColor = .ypWhite
        [searchField ,starImage, questionLabel, trackersCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func loadConstraints() {
        NSLayoutConstraint.activate([
            searchField.heightAnchor.constraint(equalToConstant: 36),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SetupConstants.padding),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SetupConstants.padding),
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            starImage.widthAnchor.constraint(equalToConstant: 80),
            starImage.heightAnchor.constraint(equalToConstant: 80),
            starImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 402),
            questionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(SetupConstants.padding * 2)),
            questionLabel.heightAnchor.constraint(equalToConstant: 18),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: starImage.bottomAnchor, constant: 8),
            trackersCollectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 30),
            trackersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: SetupConstants.padding),
            trackersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -SetupConstants.padding),
            trackersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -SetupConstants.padding)
        ])
    }
}
