//
//  TubeInteractor.swift
//  TubeStatusApp
//
//  Created by Admin on 08/11/2023.
//

import Foundation
import Combine

class TubeLineInteractor: TubeLineStatusProtocol {
    private var cancellables: Set<AnyCancellable> = []
    private let tubeDataSubject = PassthroughSubject<[TubeListViewModel], Error>()
    
    var tubeDataPublisher: AnyPublisher<[TubeListViewModel], Error> {
        return tubeDataSubject.eraseToAnyPublisher()
    }
        
    private let tubeDataService: TFLDataServiceProtocol
    
    init(tubeDataService: TFLDataServiceProtocol = TubeDataFetcher()) {
        self.tubeDataService = tubeDataService
    }
    // Function to fetch tube data from the API
    func fetchTubeData() {
        tubeDataService.fetchTubeData()
            .receive(on: DispatchQueue.main) // Switch to the main thread to update UI
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    // Handle finished state if needed
                    break
                case .failure(let error):
                    self.tubeDataSubject.send(completion: .failure(error))
                }
            }, receiveValue: { tubeData in
                self.tubeDataSubject.send(tubeData.toViewModels())
            })
            .store(in: &cancellables)
    }
    
    func refreshData() {
        // Simulate a delay for demonstration purposes
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.fetchTubeData()
        }
    }
}

// Define custom errors
enum TubeDataError: Error {
    case invalidURL
}
