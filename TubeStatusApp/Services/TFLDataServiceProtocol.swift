//
//  TFLDataServiceProc.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//
// This protocol contains all methods of fetching data from API

import Foundation
import Combine

protocol TFLDataServiceProtocol {
    func fetchTubeData() -> AnyPublisher<[TubeLine], Error>
}
