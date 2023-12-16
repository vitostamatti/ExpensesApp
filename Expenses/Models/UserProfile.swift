//
//  User.swift
//  Expenses
//
//  Created by Vito Stamatti on 4/12/23.
//

import Foundation
import SwiftUI
import SwiftData


@Model
final class UserProfile {
    var name:String
    
    @Attribute(.externalStorage) var imageData: Data?
    
    var currency:String
        
    init(name: String, imageData: Data? = nil, currency: String = "USD") {
        self.name = name
        self.imageData = imageData
        self.currency = currency
    }
}


extension UserProfile {
    static func generate(modelContext: ModelContext) {
        let user = UserProfile(name: "Your Name")
        modelContext.insert(user)
        try! modelContext.save()
    }
}
