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
    public func fetchSubscription<Model: UnmanagedModel>(_ request: NSFetchRequest<Model.RepoManaged>) -> Effect<Success<Model>, Failure<Model>> {
        Effect.run { [weak self] effectSubscriber -> AnyCancellable in
            guard let self = self else {
                effectSubscriber.send(completion: .failure(Failure(error: .unknown, fetchRequest: request)))
                return AnyCancellable {}
            }
            let id = UUID()
            let subscription = FetchRepository.Subscription<Model>(
                id: id,
                request: request,
                context: self.context
            )
            subscription.subject.sink(
                receiveCompletion: { completion in
                    effectSubscriber.send(completion: completion)
                },
                receiveValue: { value in
                    effectSubscriber.send(value)
                }
            ).store(in: &self.cancellables)
            self.subscriptions.append(subscription)
            subscription.manualFetch()
            return AnyCancellable {
                subscription.subject.send(completion: .finished)
                self.subscriptions.removeAll(where: { $0.id == subscription.id })
            }
        }
    }
}
