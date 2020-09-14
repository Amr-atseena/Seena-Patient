//
//  UserLocalDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

protocol UserLocalDataManagerProtocol: class {
    func save(user: User)
    func retriveUser() -> User
}
extension UserLocalDataManagerProtocol {
    func save(user: User) {
        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: "USER")
    }
    func retriveUser() -> User {
        let data = UserDefaults.standard.data(forKey: "USER")!
        let user = try? JSONDecoder().decode(User.self, from: data)
        return user ?? User(userId: 0, firstName: "", lastName: "", image: "", phone: "", birthDate: "", role: "")
    }
}
