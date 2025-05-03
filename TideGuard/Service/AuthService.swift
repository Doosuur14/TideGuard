//
//  AuthService.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 13.04.2025.
//

import Foundation
import Alamofire
import CoreData

final class AuthService {
    static let shared = AuthService()
    private let baseURL = "http://localhost:8080/api"
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }

    private init() {}

    private func handleSuccessfulRegistration(user: AppUser, completion: @escaping (Result<AppUser, Error>) -> Void) {
        saveUserToCoreData(
            id: Int64(user.id),
            firstName: user.firstname ?? "",
            lastName: user.lastname ?? "",
            email: user.email ?? "",
            password: user.password ?? "",
            city: user.city ?? ""
        ) { result in
            switch result {
            case .success:
                UserDefaults.standard.set(user.email, forKey: "userEmail")
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func register(firstName: String, lastName: String, email: String, password: String, city: String,  completion: @escaping (Result<AppUser, Error>) -> Void) {
        let url = "\(baseURL)/register"
        let parameters = RegistrationRequest(firstName: firstName, lastName: lastName, email: email, password: password, city: city)
        print("Sending request with parameters: \(parameters)")
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: AppUser.self) { response in
                switch response.result {
                case .success(let user):
                    print("User registered: \(user)")
                    self.handleSuccessfulRegistration(user: user, completion: completion)
                case .failure(let error):
                    print("Registration failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }



    func login( email: String, password: String,  completion: @escaping (Result<AppUser, Error>) -> Void) {
        let url = "\(baseURL)/login"
        let parameters = LoginRequest(email: email, password: password)
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: AppUser.self) { response in
                switch response.result {
                case .success(let user):
                    print("User logged in: \(user)")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    if AuthService.shared.getCurrentUser() == nil {
                        self.handleSuccessfulRegistration(user: user, completion: completion)
                    } else {
                        completion(.success(user))
                    }
                    completion(.success(user))
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }

    func getCurrentUser() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Failed to fetch user: \(error)")
            return nil
        }
    }

}


private func saveUserToCoreData(id: Int64,
                                firstName: String,
                                lastName: String,
                                email: String,
                                password: String,
                                city: String,
                                completion: @escaping((Result<User, Error>) -> Void)) {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let user = User(context: context)
    user.userId = id
    user.firstName = firstName
    user.lastName = lastName
    user.email = email
    user.password = password
    user.city = city

    do {
        try context.save()
        print("User successfully added to Core Data!")
        completion(.success(user))
    } catch {
        print("Failed to save user to Core Data: \(error)")
        completion(.failure(error))
    }
}



struct RegistrationRequest: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let city: String
}


struct LoginRequest: Codable {
    let email: String
    let password: String
}
