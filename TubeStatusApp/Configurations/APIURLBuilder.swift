//
//  APIURLBuilder.swift
//  TubeStatusApp
//
//  Created by Admin on 11/11/2023.
//
// This class appends credentials required by the API

import Foundation

// Protocol for URL building
protocol URLBuilder {
    func buildURL(using builder: String) -> URL?
}

//extending the protocol methods to append credentials
extension URLBuilder {
    func buildURL(using builder: String) -> URL? {
        var query = URLComponents(string: builder)
        let appID = URLQueryItem(name: "app_id", value: TFLCredentials.appID)
        let appKey = URLQueryItem(name: "app_key", value: TFLCredentials.appKey)
        query?.queryItems = [appID, appKey]

        guard let url = query?.url else {
            assertionFailure("Invalid API URL")
            return nil
        }
        return url
    }
}

//Build and Return the URL with Credentials
struct TFLAPI: URLBuilder {
    func buildTubeStatusURL() -> URL? {
        let tubeURL = TFLBase.url.rawValue + Line.mode.rawValue + Tube.status.rawValue
        return self.buildURL(using: tubeURL)
    }
}
