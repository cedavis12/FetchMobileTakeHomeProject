//
//  CustomError.swift
//  FetchMobileTakeHomeProject
//
//  Created by Courtney Davis on 10/31/24.
//

import Foundation

enum CustomError: LocalizedError {
    case badRequest
    case invalidResponse
    case invalidData

    public var errorDescription: String? {
        switch self {
        case .badRequest:
            return "The server was unable to process the request."
        case .invalidResponse:
            return "Invalid response from the server."
        case .invalidData:
            return "The data received from the server was invalid."
        }
    }
}

