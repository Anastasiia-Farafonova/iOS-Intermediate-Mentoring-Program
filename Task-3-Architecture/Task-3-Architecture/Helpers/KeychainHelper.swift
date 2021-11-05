//
//  KeychainHelper.swift
//  Task-3-Architecture
//
//  Created by Anastasiia Farafonova on 08.11.2021.
//

import Foundation

struct KeychainHelper<T: Codable> {
    enum KeychainError: Error {
        case saveError
        case readError
    }
    let service: String
    let account: String
    
    func save(entity: T) throws {
        guard let data = try? JSONEncoder().encode(entity) else {
            throw KeychainError.saveError
        }
        
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: service,
                                    kSecAttrAccount as String: account,
                                    kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.saveError
        }
    }
    
    func read() throws -> T {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: service,
                                    kSecAttrAccount as String: account,
                                    kSecReturnData as String: true]
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else {
            throw KeychainError.readError
        }
        
        guard let data = result as? Data,
              let entity = try? JSONDecoder().decode(T.self, from: data) else {
            throw KeychainError.readError
        }
                
        return entity
    }
}
