//
//  WeatherService.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 28.04.2025.
//

import Foundation
import Alamofire

final class WeatherService {
    static let shared = WeatherService()
    private let baseURL = "http://localhost:8080"

    private init() {}

    func fetchEvacuationData(completion: @escaping (Result<Evacuation, Error>) -> Void) {
        let url = "\(baseURL)/user/evacuation"
        guard let email = UserDefaults.standard.string(forKey: "userEmail") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User email not found"])))
            return
        }
        let headers: HTTPHeaders = ["email": email]
        AF.request(url, headers: headers)
            .validate()
            .responseDecodable(of: Evacuation.self) { response in
                switch response.result {
                case .success(let evacuation):
                    completion(.success(evacuation))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
       }

    func fetchFloodAreas(for city: String, completion: @escaping (Result<FloodArea, Error>) -> Void) {
        let url = "\(baseURL)/api/flood-areas/\(city)"
        AF.request(url)
            .validate()
            .responseDecodable(of: FloodArea.self) { response in
                switch response.result {
                case .success(let floodArea):
                    completion(.success(floodArea))
                case .failure(let error):
                    print("Failed to fetch flood areas: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }

}
