//
//  DataResult.swift
//  FitnessApp
//
//  Created by Roger Knowws on 24/12/2025.
//

import Foundation

typealias DataResult<T, U> = Result<T, U> where U: Error
