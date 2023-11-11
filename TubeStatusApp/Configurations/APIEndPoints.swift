//
//  APIEndPoints.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//

import Foundation

enum TFLBase: String {
    case url = "https://api.tfl.gov.uk/"
}

enum Line: String {
    case mode = "Line/Mode/"
}

enum Tube: String {
    case status = "tube/Status"
}
