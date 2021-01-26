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

extension AggregateRepository {
    // MARK: Public Functions
    /// Calculate the count for a fetchRequest
    /// - Parameters:
    ///     - predicate: NSPredicate
    ///     - entityDesc: NSEntityDescription
    /// - Returns
    ///     - Effect<Success<Int>, Failure<Int>>
    ///
    public func count(predicate: NSPredicate, entityDesc: NSEntityDescription) -> Effect<Success<Int>, Failure> {
        let publisher: AnyPublisher<Success<Int>, Failure> = self.count(predicate: predicate, entityDesc: entityDesc)
        return publisher.eraseToEffect()
    }

    /// Calculate the sum for a fetchRequest
    /// - Parameters:
    ///     - predicate: NSPredicate
    ///     - entityDesc: NSEntityDescription
    ///     - attributeDesc: NSAttributeDescription
    ///     - groupBy: NSAttributeDescription? = nil
    /// - Returns
    ///     - Effect<Success<Value>, Failure<Value>>
    ///
    public func sum<Value: Numeric>(predicate: NSPredicate, entityDesc: NSEntityDescription, attributeDesc: NSAttributeDescription, groupBy: NSAttributeDescription? = nil) -> Effect<Success<Value>, Failure> {
        let publisher: AnyPublisher<Success<Value>, Failure> = self.sum(predicate: predicate, entityDesc: entityDesc, attributeDesc: attributeDesc, groupBy: groupBy)
        return publisher.eraseToEffect()
    }

    /// Calculate the average for a fetchRequest
    /// - Parameters:
    ///     - predicate: NSPredicate
    ///     - entityDesc: NSEntityDescription
    ///     - attributeDesc: NSAttributeDescription
    ///     - groupBy: NSAttributeDescription? = nil
    /// - Returns
    ///     - Effect<Success<Value>, Failure<Value>>
    ///
    public func average<Value: Numeric>(predicate: NSPredicate, entityDesc: NSEntityDescription, attributeDesc: NSAttributeDescription, groupBy: NSAttributeDescription? = nil) -> Effect<Success<Value>, Failure> {
        let publisher: AnyPublisher<Success<Value>, Failure> = self.sum(predicate: predicate, entityDesc: entityDesc, attributeDesc: attributeDesc, groupBy: groupBy)
        return publisher.eraseToEffect()
    }

    /// Calculate the min for a fetchRequest
    /// - Parameters:
    ///     - predicate: NSPredicate
    ///     - entityDesc: NSEntityDescription
    ///     - attributeDesc: NSAttributeDescription
    ///     - groupBy: NSAttributeDescription? = nil
    /// - Returns
    ///     - Effect<Success<Value>, Failure<Value>>
    ///
    public func min<Value: Numeric>(predicate: NSPredicate, entityDesc: NSEntityDescription, attributeDesc: NSAttributeDescription, groupBy: NSAttributeDescription? = nil) -> Effect<Success<Value>, Failure> {
        let publisher: AnyPublisher<Success<Value>, Failure> = self.sum(predicate: predicate, entityDesc: entityDesc, attributeDesc: attributeDesc, groupBy: groupBy)
        return publisher.eraseToEffect()
    }

    /// Calculate the max for a fetchRequest
    /// - Parameters:
    ///     - predicate: NSPredicate
    ///     - entityDesc: NSEntityDescription
    ///     - attributeDesc: NSAttributeDescription
    ///     - groupBy: NSAttributeDescription? = nil
    /// - Returns
    ///     - Effect<Success<Value>, Failure<Value>>
    ///
    public func max<Value: Numeric>(predicate: NSPredicate, entityDesc: NSEntityDescription, attributeDesc: NSAttributeDescription, groupBy: NSAttributeDescription? = nil) -> Effect<Success<Value>, Failure> {
        let publisher: AnyPublisher<Success<Value>, Failure> = self.sum(predicate: predicate, entityDesc: entityDesc, attributeDesc: attributeDesc, groupBy: groupBy)
        return publisher.eraseToEffect()
    }
}
