//
//  File.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//
// This protocol handles all abstract overview of TubeLineStatusView

import Foundation
import Combine

// Methods used by TubeLineStatusView
protocol TubeLineStatusProtocol {
    var tubeDataPublisher: AnyPublisher<[TubeListViewModel], Error> { get }
    func fetchTubeData()
    func refreshData()
}
