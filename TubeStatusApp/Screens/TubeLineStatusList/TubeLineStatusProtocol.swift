//
//  File.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//

import Foundation
import Combine

protocol TubeLineStatusProtocol {
    var tubeDataPublisher: AnyPublisher<[TubeListViewModel], Error> { get }
    func fetchTubeData()
    func refreshData()
}
