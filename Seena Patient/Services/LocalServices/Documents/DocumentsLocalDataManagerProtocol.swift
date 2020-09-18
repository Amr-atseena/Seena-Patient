//
//  DocumentsLocalDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 16/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

protocol DocumentsLocalDataManagerProtocol: class {
    func save(documents: [Document], forKey key: DocumentType)
    func retrivDocumets(forKey key: DocumentType) -> [Document]
}
extension DocumentsLocalDataManagerProtocol {
    func save(documents: [Document], forKey key: DocumentType) {
        let data = try? JSONEncoder().encode(documents)
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    func retrivDocumets(forKey key: DocumentType) -> [Document] {
        let data = UserDefaults.standard.data(forKey: key.rawValue)!
        let documents = try? JSONDecoder().decode([Document].self, from: data)
        return documents ?? []
    }

}
