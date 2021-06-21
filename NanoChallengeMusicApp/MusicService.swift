//
//  MusicService.swift
//  Delegated
//
//  Created by Rafael Victor Ruwer Araujo on 16/06/21.
//

import Foundation
import UIKit

// MARK: Music

struct Music: Hashable, Decodable {
    let id: String
    
    let title: String
    let artist: String
    let length: TimeInterval
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - MusicCollection

struct MusicCollection: Hashable, Decodable {
    enum MusicCollectionType: String, Decodable {
        case playlist
        case album
    }
    
    let id: String
    
    let title: String
    let mainPerson: String
    let referenceDate: Date
    
    var musics: [Music]
    
    let type: MusicCollectionType
    let albumDescription: String?
    let albumArtistDescription: String?
    
    var supportsEdition: Bool {
        type == .playlist
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Queue

struct Queue {
    var nowPlaying: Music?
    
    var collection: MusicCollection?
    var nextInCollection: [Music]
    
    var nextSuggested: [Music]
}

// MARK: - MusicService

final class MusicService {
    private var collections: Set<MusicCollection>
    private(set) var favoriteMusics: [Music]
    private(set) var queue: Queue
    
    init() throws {
        // may the superior entity (if such exists) forgive me for such terrible practice :'//
        let mockDataUrl = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try Data(contentsOf: mockDataUrl)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.collections = try decoder.decode(Set<MusicCollection>.self, from: data)
        
        let allMusics = collections.flatMap(\.musics)
        let favoriteMusicsIDs = UserDefaults.standard.array(forKey: "favorite-musics-ids") as? [String] ?? []
        self.favoriteMusics = allMusics.filter { favoriteMusicsIDs.contains($0.id) }
        
        self.queue = Queue(nowPlaying: nil, collection: nil, nextInCollection: [], nextSuggested: [])
    }
    
    // MARK: Library
    
    func loadLibrary() -> [MusicCollection] {
        collections.sorted { $0.referenceDate > $1.referenceDate }
    }
    
    func getCollection(id: String) -> MusicCollection? {
        collections.first { $0.id == id }
    }
    
    func removeMusic(_ music: Music, from collection: MusicCollection) {
        guard collection.supportsEdition else { return }
        
        // since MusicCollection is a value type (i.e. struct),
        // we need to remove the existing value from collections and then insert back the modified one
        collections.remove(collection)
        
        var collectionCopy = collection
        collectionCopy.musics.removeAll { $0.id == music.id }
        collections.insert(collectionCopy)
    }
    
    // MARK: Cover art
    
    /// Gets the cover art image for a collection or a music.
    ///
    /// - Parameter itemId: ID of a `Music` or `MusicCollection`.
    /// - Returns: Image object representing the item's cover art.
    func getCoverImage(forItemIded itemId: String) -> UIImage? {
        UIImage(named: itemId)
    }
    
    // MARK: Favorites
    
    func toggleFavorite(music: Music, isFavorite: Bool) {
        if isFavorite {
            favoriteMusics.removeAll { $0 == music }
        } else {
            favoriteMusics.append(music)
        }
        
        // update persisted list with IDs of favorite musics
        UserDefaults.standard.setValue(favoriteMusics.map(\.id), forKey: "favorite-musics-ids")
    }
    
    // MARK: Playing/Queue
    
    func startPlaying(collection: MusicCollection) {
        let nonRepeatedMusics = Set(collections.flatMap(\.musics)).subtracting(collection.musics)
        let suggestions = (0..<10).compactMap { _ in nonRepeatedMusics.randomElement() }
        
        queue = Queue(
            nowPlaying: collection.musics.first,
            collection: collection,
            nextInCollection: Array(collection.musics.dropFirst()),
            nextSuggested: suggestions)
    }
    
    func startPlaying(music: Music) {
        queue = Queue(nowPlaying: music, collection: nil, nextInCollection: [], nextSuggested: [])
    }
    
    func removeFromQueue(music: Music) {
        queue.nextInCollection.removeAll { $0 == music }
        queue.nextSuggested.removeAll { $0 == music }
    }
}
