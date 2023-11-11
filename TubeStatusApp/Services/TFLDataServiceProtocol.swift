//
//  TFLDataServiceProc.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//

import Foundation
import Combine

protocol TFLDataServiceProtocol {
    func fetchTubeData() -> AnyPublisher<[TubeLine], Error>
}
