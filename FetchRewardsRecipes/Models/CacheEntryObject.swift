//
//  CacheEntryObject.swift
//  FetchRecipesSwiftUI
//
//  Created by David Rynn on 12/25/24.
// See: https://developer.apple.com/tutorials/app-dev-training/caching-network-data

import UIKit

/// A class to hold a CacheEntry. Immutable because of `final` keyword and `let` property, so can be passed from threads.
final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) { self.entry = entry }
}

/// An enumeration of cache entries.
enum CacheEntry {
    case inProgress(Task<Data, Error>)
    case ready(Data)
}
