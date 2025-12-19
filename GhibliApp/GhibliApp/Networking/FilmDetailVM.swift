//
//  PersonVM.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import Foundation
import Observation

@Observable
class FilmDetailVM {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }

    var state: State = .idle

    private let service: GhibliService

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch(for film: Film) async {
        guard state == .idle else { return }
        self.state = .loading
        do {
            var loadedPeople: [Person] = []
            
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoUrl in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(
                            from: personInfoUrl
                        )
                    }
                }
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            self.state = .loaded(loadedPeople)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error("Unkown error")
        }
    }

}
