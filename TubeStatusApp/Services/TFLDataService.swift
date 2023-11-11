//
//  APIService.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//

import Foundation
import Combine

class TubeDataFetcher: TFLDataServiceProtocol {
    func fetchTubeData() -> AnyPublisher<[TubeLine], Error> {
        
        guard let url = TFLAPI().buildTubeStatusURL() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let request = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [TubeLine].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
