//
//  User.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 14.04.2025.
//

import Foundation

struct AppUser: Codable {
    let id: Int
    let firstname: String?
    let lastname: String?
    let email: String?
    let password: String?
    let city: String?

}
