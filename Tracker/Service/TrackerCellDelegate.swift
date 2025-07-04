//
//  TrackerCellDelegate.swift
//  Tracker
//
//  Created by R Kolos on 25.06.2025.
//

import UIKit

protocol TrackerCellDelegate: AnyObject {
    func trackerCellDidTapComplete(_ cell: CellTracker, isCompleted: Bool)
}
