//: Playground - noun: a place where people can play

import UIKit

protocol KeyNamespaceable {
    func namespaced<T : RawRepresentable>(_ key : T) -> String
}

extension KeyNamespaceable {
    func namespaced<T : RawRepresentable>(_ key : T) -> String {
        return "\(Self.self).\(key.rawValue)"
    }
}

protocol BoolDefaultSettable : KeyNamespaceable {
    associatedtype BoolKey : RawRepresentable
}

extension BoolDefaultSettable where BoolKey.RawValue == String {
    func set(_ value: Bool, forKey key: BoolKey) {
        let key = namespaced(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func bool(forKey key: BoolKey) -> Bool {
        let key = namespaced(key)
        return UserDefaults.standard.bool(forKey: key)
    }
}

extension UserDefaults : BoolDefaultSettable {
    enum BoolKey : String {
        
        case isUserLoggedIn
    }
}

UserDefaults.standard.set(true, forKey: .isUserLoggedIn)
UserDefaults.standard.bool(forKey: .isUserLoggedIn)

