//
//  NSCache+subscript.swift
//  FetchRecipesSwiftUI
//
//  See: https://developer.apple.com/tutorials/app-dev-training/caching-network-data

import Foundation

/// Adds dictionary-like functionality - by using URL as "key" can get/set object "value"
extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ url: URL) -> CacheEntry? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
