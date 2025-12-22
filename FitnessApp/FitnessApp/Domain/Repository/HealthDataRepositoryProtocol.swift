//
//  HealthDataRepositoryProtocol.swift
//  FitnessApp
//
//  Created by Roger Knowws on 22/12/2025.
//

import Foundation

protocol HealthDataRepositoryProtocol {
    func getDataFor(type HealthDataTypeString: String) async
}
