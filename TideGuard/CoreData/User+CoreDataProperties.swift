//
//  User+CoreDataProperties.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 14.04.2025.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    @NSManaged public var userId: Int64

}

extension User : Identifiable {

}
