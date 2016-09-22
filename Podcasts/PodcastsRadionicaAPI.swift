//
//  RadionicaAPI.swift
//  Podcasts
//
//  Created by Angel Torres on 20/09/16.
//  Copyright © 2016 Angel Torres. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let PodcastsRadionicaProvider = MoyaProvider<PodcastsRadionica>(plugins: [
        NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)
    ])

public enum PodcastsRadionica {
    case podcasts
    case episodesPodcast(Int)
    
}

// MARK: - TargetType Protocol Implementation
extension PodcastsRadionica: TargetType{
    public var baseURL: URL { return URL(string: "http://www.radionica.rocks/api-radio")! }
    public var path: String {
        switch self {
        case .podcasts:
            return "/podcasts"
        case .episodesPodcast(let id):
            return "/episodios-podcast/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .podcasts, .episodesPodcast:
            return .GET
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .podcasts, .episodesPodcast:
            return nil
        }
    }
    public var task: Task {
        return .request
    }
    
    public var sampleData: Data {
        switch self {
        case .podcasts:
            return "{\"id\": \"Podcast Id\", \"serie\": \"Podcast Nombre\", \"descripcion\": \"Podcast Descripcion\", \"imagen\": {\"src\": \"Imagen src\", \"alt\": \"Imagen alt\"}}".data(using: String.Encoding.utf8)!
        case .episodesPodcast(_):
            return "{\"id\": \"Episodio Id\", \"episodio\": \"Episodio Nombre\", \"serie\": \"Podcast Nombre\", \"descripcion\": \"Episodio Descripcion\", \"audio\": \"Episodio Audio\", \"imagen\": {\"src\": \"Imagen src\", \"alt\": \"Imagen alt\"}}".data(using: String.Encoding.utf8)!
        }
    }
}
