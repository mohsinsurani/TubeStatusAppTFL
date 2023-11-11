//
//  APIEndPoints.swift
//  TubeStatusApp
//
//  Created by Admin on 10/11/2023.
//
// This class handles all URL endpoints for this app


import Foundation

//base url
enum TFLBase: String {
    case url = "https://api.tfl.gov.uk/"
}

//Line Module
enum Line: String {
    case mode = "Line/Mode/"
}

//Tube Module
enum Tube: String {
    case status = "tube/Status"
}
