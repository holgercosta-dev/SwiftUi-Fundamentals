//
//  FilmsVM.swift
//  GhibliApp
//
//  Created by Roger Knowws on 19/12/2025.
//

import Foundation
import Observation

@Observable
class FilmsVM {

    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }

    var state: State = .idle
    var films: [Film] = []
    
    private let service: GhibliService
    
    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch() async {
        guard state == .idle else { return }
        state = .loading
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error("Unkown error")
        }
    }
}
