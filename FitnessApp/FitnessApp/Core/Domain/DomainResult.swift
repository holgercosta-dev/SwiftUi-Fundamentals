//
//  DomainResult.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

typealias DomainResult<T, U> = Result<T, U> where U: Error
