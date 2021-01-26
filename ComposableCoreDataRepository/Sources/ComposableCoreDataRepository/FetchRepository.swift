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

extension FetchRepository {
    // MARK: Functions/Endpoints
    /// Fetch a single array of value types corresponding to a NSManagedObject sub class.
    /// - Parameters
    ///     - _ request: NSFetchRequest<Model.RepoManaged>
    /// - Returns
    ///     - AnyPublisher<Success<Model>, Failure<Model>>
    ///
    public func fetch<Model: UnmanagedModel>(_ request: NSFetchRequest<Model.RepoManaged>) -> Effect<Success<Model>, Failure<Model>> {
        let publisher: AnyPublisher<Success<Model>, Failure<Model>> = self.fetch(request)
        return publisher.eraseToEffect()
    }
}
