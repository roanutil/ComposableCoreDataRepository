//
//  CRUDRepository.swift
//  
//
//  Created by Andrew Roan on 1/25/21.
//

import CoreData
import Combine
import ComposableArchitecture
import CoreDataRepository

extension CRUDRepository {
    // MARK: Functions/Endpoints
    /// Create an instance of a NSManagedObject sub class from a corresponding value type. Supports specifying a transactionAuthor that is applied to the context before saving.
    /// - Types
    ///     - Model: UnmanagedModel
    /// - Parameters
    ///     -   _ item: Model
    ///     - transactionAuthor: String = ""
    /// - Returns
    ///     - AnyPublisher<Success<Model>.create(Model), Failure<Model>.create(Model, RepositoryErrors)>
    ///
    public func create<Model: UnmanagedModel>(_ item: Model, transactionAuthor: String = "") -> Effect<Success<Model>, Failure<Model>> {
        let publisher: AnyPublisher<Success<Model>, Failure<Model>> = self.create(item, transactionAuthor: transactionAuthor)
        return publisher.eraseToEffect()
    }

    /// Read an instance of a NSManagedObject sub class as a corresponding value type
    /// - Types
    ///     - Model: UnmanagedModel
    /// - Parameters
    ///     -   _ objectID: NSManagedObjectID
    /// - Returns
    ///     - Effect<Success<Model>.read(Model), Failure<Model>.read(NSManagedObjectID, RepositoryErrors)>
    ///
    public func read<Model: UnmanagedModel>(_ objectID: NSManagedObjectID) -> Effect<Success<Model>, Failure<Model>> {
        let publisher: AnyPublisher<Success<Model>, Failure<Model>> = self.read(objectID)
        return publisher.eraseToEffect()
    }

    /// Update an instance of a NSManagedObject sub class from a corresponding value type. Supports specifying a transactionAuthor that is applied to the context before saving.
    /// - Types
    ///     - Model: UnmanagedModel
    /// - Parameters
    ///     - objectID: NSManagedObjectID
    ///     - with  item: Model
    ///     - transactionAuthor: String = ""
    /// - Returns
    ///     - Effect<Success<Model>.update(Model), Failure<Model>.update(Model, RepositoryErrors)>
    ///
    public func update<Model: UnmanagedModel>(
        _ objectID: NSManagedObjectID,
        with item: Model,
        transactionAuthor: String = ""
    ) -> Effect<Success<Model>, Failure<Model>> {
        let publisher: AnyPublisher<Success<Model>, Failure<Model>> = self.update(objectID, with: item, transactionAuthor: transactionAuthor)
        return publisher.eraseToEffect()
    }

    /// Delete an instance of a NSManagedObject sub class. Supports specifying a transactionAuthor that is applied to the context before saving.
    /// - Types
    ///     - Model: UnmanagedModel
    /// - Parameters
    ///     - objectID: NSManagedObjectID
    ///     - transactionAuthor: String = ""
    /// - Returns
    ///     - Effect<Success<Model>.delete(Model), Failure<Model>.delete(Model, RepositoryErrors)>
    ///
    public func delete<Model: UnmanagedModel>(_ objectID: NSManagedObjectID, transactionAuthor: String = "") -> Effect<Success<Model>, Failure<Model>> {
        let publisher: AnyPublisher<Success<Model>, Failure<Model>> = self.delete(objectID, transactionAuthor: transactionAuthor)
        return publisher.eraseToEffect()
    }
}
