//
//  ContentCore.swift
//  pres
//
//  Created by Pierre Caporossi on 18/10/2022.
//

import ComposableArchitecture
import Foundation

// MARK: State

struct ContentState: Equatable {
    var count: Int
    var showAlert: Bool
    var isLoading: Bool

    init(count: Int = 0, showAlert: Bool = false, isLoading: Bool = false) {
        self.count = count
        self.showAlert = showAlert
        self.isLoading = isLoading
    }
}

// MARK: Actions

public enum ContentAction: Equatable {
    case increment
    case decrement
    case checkIsNumberValid
    case checkIsNumberValidResponse(Result<Bool, Never>)
    case toggleBottomSheet
}

// MARK: Environment

struct ContentViewEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var numberClient: NumberClient
}

// MARK: Reducer

let reducer = Reducer<ContentState, ContentAction, ContentViewEnvironment> { state, action, env in
    switch action {
    case .increment:
        state.count = state.count + 1
        return .none
    case .decrement:
        state.count = state.count - 1
        return .none
    case .checkIsNumberValid:
        state.isLoading = true
        return env.numberClient.fetchIsValid(state.count).catchToEffect { .checkIsNumberValidResponse($0) }
    case let .checkIsNumberValidResponse(.success(value)):
        state.isLoading = false
        state.showAlert = value
        return .none
    case .toggleBottomSheet:
        state.showAlert.toggle()
        return .none
    }
}
