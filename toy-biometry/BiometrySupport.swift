//
//  BiometrySupport.swift
//  toy-biometry
//
//  Created by Faiz Mokhtar on 13/05/2018.
//  Copyright © 2018 Faiz Mokhtar. All rights reserved.
//

import Foundation

public enum BiometrySupport {
    public enum Biometry  {
        case touchID
        case faceID
    }

    case available(Biometry)
    case lockedOut(Biometry)
    case notAvailable(Biometry) // cover not available and not enrolled states
    case none

    public var biometry: Biometry? {
        switch self {
        case .none,
             .lockedOut,
             .notAvailable:
            return nil
        case let .available(biometry):
            return biometry
        }
    }
}
