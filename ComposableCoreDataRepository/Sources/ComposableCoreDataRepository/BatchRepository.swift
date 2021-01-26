//
//  File.swift
//  
//
//  Created by Andrew Roan on 1/25/21.
//

import CoreData
import Combine
import CoreDataRepository
import ComposableArchitecture

extension BatchRepository {
    // MARK: Functions
    /// Batch insert objects into CoreData
    /// - Parameters
    ///     - _ request: NSBatchInsertRequest
    /// - Returns
    ///     - Effect<Success, Failure>
    public func insert(_ request: NSBatchInsertRequest) -> Effect<Success, Failure> {
        let publisher: AnyPublisher<Success, Failure> = self.insert(request)
        return publisher.eraseToEffect()
    }

    /// Batch update objects in CoreData
    /// - Parameters
    ///     - _ request: NSBatchInsertRequest
    /// - Returns
    ///     - Effect<Success, Failure>
    public func update(_ request: NSBatchUpdateRequest) -> Effect<Success, Failure> {
        let publisher: AnyPublisher<Success, Failure> = self.update(request)
        return publisher.eraseToEffect()
    }

    /// Batch delete objects from CoreData
    /// - Parameters
    ///     - _ request: NSBatchInsertRequest
    /// - Returns
    ///     - Effect<Success, Failure>
    public func delete(_ request: NSBatchDeleteRequest) -> Effect<Success, Failure> {
        let publisher: AnyPublisher<Success, Failure> = self.delete(request)
        return publisher.eraseToEffect()
    }
}
