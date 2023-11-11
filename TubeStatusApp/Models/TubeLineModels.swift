//
//  Models.swift
//  TubeStatusApp
//
//  Created by Admin on 09/11/2023.
//
// This class is responsibile for handling codable protocols

import Foundation

//This model will be used to bind the Tube data from the API
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

//This model handles the status of each tube
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

//Converting the Codable models to ViewModel of the UI
extension TubeLine {
    func toViewModel() -> TubeListViewModel? {
        guard let lineColor = TubeColors(rawValue: self.id),
              let severity = self.lineStatuses.first?.statusSeverity,
              let lineStatus = TubeLineStatus(rawValue: severity)
        else { return nil } //return nil if any of this data is empty
        
        return TubeListViewModel(lineName: self.name, lineUniqueColor: lineColor, lineStatus: lineStatus)
    }
}

//Converting the Array of Codable models to ViewModel of the UI
extension Array where Element == TubeLine {
    func toViewModels() -> [TubeListViewModel] {
        //using compactMap to remove null values
        return self.compactMap({$0.toViewModel()})
    }
}
