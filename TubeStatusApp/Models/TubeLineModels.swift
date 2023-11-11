//
//  Models.swift
//  TubeStatusApp
//
//  Created by Admin on 09/11/2023.
//

import Foundation

struct TubeLine: Codable {
    let id: String
    let name: String
    let lineStatuses: [LineStatus]
    // Add other properties as needed

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lineStatuses
        // Map other properties here
    }
}

struct LineStatus: Codable {
    let statusSeverityDescription: String
    let statusSeverity: Int
    // Add other properties as needed

    enum CodingKeys: String, CodingKey {
        case statusSeverityDescription
        case statusSeverity
        // Map other properties here
    }
}

extension TubeLine {
    func toViewModel() -> TubeListViewModel? {
        guard let lineColor = TubeColors(rawValue: self.id),
              let severity = self.lineStatuses.first?.statusSeverity,
              let lineStatus = TubeLineStatus(rawValue: severity)
        else { return nil }
        
        return TubeListViewModel(lineName: self.name, lineUniqueColor: lineColor, lineStatus: lineStatus)
    }
}

extension Array where Element == TubeLine {
    func toViewModels() -> [TubeListViewModel] {
        return self.compactMap({$0.toViewModel()})
    }
}
