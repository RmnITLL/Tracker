//
//  ScheduleServiceDelegate.swift
//  Tracker
//
//  Created by R Kolos on 25.06.2025.
//

import Foundation

protocol ScheduleServiceDelegate: AnyObject {
    func didSelectSchedule(days: [WeekDay])
}
