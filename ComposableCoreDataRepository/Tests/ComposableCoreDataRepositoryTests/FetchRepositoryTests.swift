//
//  File.swift
//  
//
//  Created by Andrew Roan on 1/26/21.
//

import CoreData
import Combine
import XCTest
import ComposableArchitecture
import CoreDataRepository
@testable import ComposableCoreDataRepository

final class FetchRepositoryTests: CoreDataXCTestCase {

    static var allTests = [
        ("testFetchSuccess", testFetchSubscriptionSuccess)
    ]

    typealias Success = FetchRepository.Success<Movie>
    typealias Failure = FetchRepository.Failure<Movie>

    let fetchRequest: NSFetchRequest<RepoMovie> = {
        let request = NSFetchRequest<RepoMovie>(entityName: "RepoMovie")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \RepoMovie.title, ascending: true)]
        return request
    }()
    let movies = [
        Movie(id: UUID(), title: "A", releaseDate: Date()),
        Movie(id: UUID(), title: "B", releaseDate: Date()),
        Movie(id: UUID(), title: "C", releaseDate: Date()),
        Movie(id: UUID(), title: "D", releaseDate: Date()),
        Movie(id: UUID(), title: "E", releaseDate: Date()),
    ]
    var expectedMovies = [Movie]()
    var _repository: FetchRepository?
    var repository: FetchRepository { _repository! }

    override func setUp() {
        super.setUp()
        self._repository = FetchRepository(context: self.backgroundContext)
        _ = movies.map { $0.asRepoManaged(in: viewContext) }
        try? viewContext.save()
        expectedMovies = try! viewContext.fetch(fetchRequest).map { $0.asUnmanaged }
    }

    override func tearDown() {
        super.tearDown()
        self._repository = nil
        expectedMovies = []
    }

    func testFetchSubscriptionSuccess() {
        let firstExp = expectation(description: "Fetch movies from CoreData")
        let secondExp = expectation(description: "Fetch movies again after CoreData context is updated")
        let finalExp = expectation(description: "Finish fetching movies after canceled.")
        var resultCount = 0
        let result: Effect<Success, Failure> = repository.fetchSubscription(fetchRequest).cancellable(id: "fetchSubscription")
        let cancellable = result.subscribe(on: backgroundQueue)
            .receive(on: mainQueue)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    finalExp.fulfill()
                default:
                    XCTFail("Not expecting failure")
                }
        }, receiveValue: { value in
            resultCount += 1
            switch resultCount {
            case 1:
                assert(value.items.count == 5, "Result items count should match expectation")
                assert(value.items == self.expectedMovies, "Result items should match expectations")
                firstExp.fulfill()
            case 2:
                assert(value.items.count == 4, "Result items count should match expectation")
                assert(value.items == Array(self.expectedMovies[0...3]), "Result items should match expectations")
                secondExp.fulfill()
            default:
                break
            }
            
        })
        wait(for: [firstExp], timeout: 5)
        let crudRepository = CRUDRepository(context: self.backgroundContext)
        let _: Effect<CRUDRepository.Success<Movie>, CRUDRepository.Failure<Movie>> = crudRepository.delete(self.expectedMovies.last!.objectID!)
        wait(for: [secondExp], timeout: 5)
        Effect.cancel(id: "fetchSubscription")
        wait(for: [finalExp], timeout: 5)
    }
}
