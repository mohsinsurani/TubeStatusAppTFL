//
//  APIService.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//
// This class confirms to TFLDataServiceProtocol and implement its methods

import Foundation
import Combine

class TubeDataFetcher: TFLDataServiceProtocol {
    func fetchTubeData() -> AnyPublisher<[TubeLine], Error> {
        
        //build URL and return error for invalid
        guard let url = TFLAPI().buildTubeStatusURL() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let request = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [TubeLine].self, decoder: JSONDecoder()) //decoding with codable protocol
            .eraseToAnyPublisher()
    }
}
