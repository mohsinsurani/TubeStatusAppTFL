//
//  TubeStatusAppTests.swift
//  TubeStatusAppTests
//
//  Created by Admin on 08/11/2023.
//

import XCTest
import Combine
import Foundation

@testable import TubeStatusApp

final class TubeStatusAppTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchTubeData() {
        let expectation = XCTestExpectation(description: "Fetch Tube Data")
        
        TubeDataFetcher().fetchTubeData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { tubeData in
                XCTAssertGreaterThan(tubeData.count, 0, "Received tube data is not empty")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testAPICallPerformance() {
        // This measures the performance of your API call
        measure {
            let expectation = XCTestExpectation(description: "API Call")
            
            TubeDataFetcher().fetchTubeData()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Failed with error: \(error.localizedDescription)")
                    }
                }, receiveValue: { tubeData in
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 20.0) // Adjust timeout as needed
        }
    }
    
    func testbasicLatency() {
        let expectation = XCTestExpectation(description: "Check latency")
        
        let startTime = CFAbsoluteTimeGetCurrent()
        
        TubeDataFetcher().fetchTubeData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { tubeData in
                let endTime = CFAbsoluteTimeGetCurrent()
                let latency = endTime - startTime
                print("Network Request Latency: \(latency) seconds")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 20.0) // Adjust timeout as needed
        
    }
    
    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
}
