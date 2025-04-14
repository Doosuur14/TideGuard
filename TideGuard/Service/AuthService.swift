//
//  AuthService.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 13.04.2025.
//

import Foundation
import Alamofire

final class AuthService {
    static let shared = AuthService()
    private let baseURL = "http://localhost:8080/api"

    private init() {}

    func register(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<AppUser, Error>) -> Void) {
        let url = "\(baseURL)/users"
        let parameters = RegistrationRequest(firstName: firstName, lastName: lastName, email: email, password: password)

        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: AppUser.self) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }

            }
    }

}

struct RegistrationRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
