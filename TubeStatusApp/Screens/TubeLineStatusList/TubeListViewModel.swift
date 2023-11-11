//
//  TubeListViewModel.swift
//  TubeStatusApp
//
//  Created by Admin on 08/11/2023.
//

import Foundation
import SwiftUI

struct TubeListViewModel {
    var lineName: String
    var lineUniqueColor: TubeColors
    var lineStatus: TubeLineStatus
}

enum TubeColors: String {
    case metropolitan = "metropolitan"
    case northern = "northern"
    case piccadilly = "piccadilly"
    case waterloo = "waterloo-city"
    case bakerloo = "bakerloo"
    case central = "central"
    case circle = "circle"
    case district = "district"
    case hammersmith = "hammersmith-city"
    case jubilee = "jubilee"
    case victoria = "victoria"

    var Color: UIColor {
        switch self {
        case .metropolitan: return UIColor(red: 116/255, green: 16/255, blue: 85/255, alpha: 1)
        case .northern: return UIColor.black
        case .piccadilly: return UIColor(red: 0, green: 24/255, blue: 168/255, alpha: 1)
        case .waterloo: return UIColor(red: 118/255, green: 207/255, blue: 188/255, alpha: 1)
        case .bakerloo: return UIColor(red: 137/255, green: 78/255, blue: 36/255, alpha: 1)
        case .central: return UIColor(red: 220/255, green: 26/255, blue: 30/255, alpha: 1)
        case .circle: return UIColor(red: 255/255, green: 206/255, blue: 0, alpha: 1)
        case .district: return UIColor(red: 0, green: 114/255, blue: 41/255, alpha: 1)
        case .hammersmith: return UIColor(red: 214/255, green: 152/255, blue: 174/255, alpha: 1)
        case .jubilee: return UIColor(red: 106/255, green: 114/255, blue: 120/255, alpha: 1)
        case .victoria: return UIColor(red: 0, green: 160/255, blue: 226/255, alpha: 1)
        }
    }
}

enum TubeLineStatus: Int {
    case specialService = 0
    case closed = 1
    case suspended = 2
    case partSuspended = 3
    case plannedClosure = 4
    case partClosure = 5
    case severeDelays = 6
    case reducedService = 7
    case busService = 8
    case minorDelays = 9
    case goodService = 10
    case partClosed = 11
    case exitOnly = 12
    case noStepFreeAccess = 13
    case changeOfFrequency = 14
    case diverted = 15
    case notRunning = 16
    case issuesReported = 17
    case noIssues = 18
    case information = 19
    
    var description: String {
        switch self {
        case .specialService: return "Special Service"
        case .closed: return "Closed"
        case .suspended: return "Suspended"
        case .partSuspended: return "Part Suspended"
        case .plannedClosure: return "Planned Closure"
        case .partClosure: return "Part Closure"
        case .severeDelays: return "Severe Delays"
        case .reducedService: return "Reduced Service"
        case .busService: return "Bus Service"
        case .minorDelays: return "Minor Delays"
        case .goodService: return "Good Service"
        case .partClosed: return "Part Closed"
        case .exitOnly: return "Exit Only"
        case .noStepFreeAccess: return "No Step Free Access"
        case .changeOfFrequency: return "Change of Frequency"
        case .diverted: return "Diverted"
        case .notRunning: return "Not Running"
        case .issuesReported: return "Issues Reported"
        case .noIssues: return "No Issues"
        case .information: return "Information"
        }
    }
    
    var color: Color {
        switch self {
        case .specialService, .closed, .suspended, .partSuspended, .plannedClosure, .partClosure, .severeDelays, .reducedService, .busService, .exitOnly, .notRunning, .issuesReported: return .red
        case .minorDelays, .changeOfFrequency, .diverted: return .yellow
        case .goodService, .noIssues: return .green
        case .information: return .blue
        default: return .black
        }
    }
}
