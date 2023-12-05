//
//  TubeInteractor.swift
//  TubeStatusApp
//
//  Created by Admin on 09/11/2023.
//
// This interactor handles all operations of TubeLineStatusView
// Protcols - TubeLineStatusProtocol & TFLDataServiceProtocol

import Foundation
import Combine

class TubeLineInteractor: TubeLineStatusProtocol {
    private var cancellables: Set<AnyCancellable> = []
    private let tubeDataSubject = PassthroughSubject<[TubeListViewModel], Error>()
    
    //publisher for transmitting data
    var tubeDataPublisher: AnyPublisher<[TubeListViewModel], Error> {
        return tubeDataSubject.eraseToAnyPublisher()
    }
        
    private let tubeDataService: TFLDataServiceProtocol
    
    // Managing the dependency
    init(tubeDataService: TFLDataServiceProtocol = TubeDataFetcher()) {
        self.tubeDataService = tubeDataService
    }
    
    // Function to fetch tube data from the API
    func fetchTubeData() {
        tubeDataService.fetchTubeData()
            .subscribe(on: DispatchQueue.global(qos: .userInitiated)) // as data needs to display urgent
            .receive(on: DispatchQueue.main) // Switch to the main thread to update UI
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.tubeDataSubject.send(completion: .failure(error))
                }
            }, receiveValue: { tubeData in
                // Sending the data back to View
                self.tubeDataSubject.send(tubeData.toViewModels())
            })
            .store(in: &cancellables)
    }
}

// Define custom errors
enum TubeDataError: Error {
    case invalidURL
}
