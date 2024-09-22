//
//  NetworkManager.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 24/09/2024.
//

import Foundation

class NetworkManager {
    
    enum NetworkError: LocalizedError {
        case urlResponseError(url: URL)
        case unknownError
        
        var errorDescription: String? {
            switch self {
            case .urlResponseError(let url):
                return "URL Response Error occurred: \(url)"
            case .unknownError:
                return "An unknown error occurred"
            }
        }
    }
    
    static func fetch(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        try manageURLResponse(response: response, url: url)
        return data
    }

    static func manageURLResponse(response: URLResponse, url: URL) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.urlResponseError(url: url)
        }
    }
}

