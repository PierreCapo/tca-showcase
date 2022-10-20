//
//  Client.swift
//  pres
//
//  Created by Pierre Caporossi on 18/10/2022.
//

import Combine
import ComposableArchitecture
import Foundation

struct NumberClient {
    var fetchIsValid: (Int) -> Effect<Bool, Never>
}

extension NumberClient {
    static let live: NumberClient = .init(fetchIsValid: { number in
        // simulating an API call
        Effect<Bool, Never>(value: number % 2 == 0)
            .delay(for: 1, scheduler: RunLoop.main)
            .eraseToEffect()
    })

    static let mockSuccess: NumberClient = .init(fetchIsValid: { _ in
        Effect(value: true)
    })
}
