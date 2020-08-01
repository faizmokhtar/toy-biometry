//
//  BiometricAuth.swift
//  toy-biometry
//
//  Created by Faiz Mokhtar on 13/05/2018.
//  Copyright © 2018 Faiz Mokhtar. All rights reserved.
//

import Foundation
import LocalAuthentication

public final class BiometricAuth {

    public var supportedBiometry: BiometrySupport {

        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if #available(iOS 11.0, *) {
                switch context.biometryType {
                case .faceID:
                    return .available(.faceID)
                case .touchID:
                    return .available(.touchID)
                default:
                    return .none
                }
            }

            return .available(.touchID)
        }

        if let error = error {

            let code = LAError(_nsError: error as NSError).code

            if #available(iOS 11.0, *) {
                switch(code, context.biometryType) {
                case (.biometryLockout, LABiometryType.faceID):
                    return .lockedOut(.faceID)
                case (.biometryLockout, LABiometryType.touchID):
                    return .lockedOut(.touchID)
                case (.biometryNotAvailable, LABiometryType.faceID),
                     (.biometryNotEnrolled, LABiometryType.faceID):
                    return .notAvailable(.faceID)
                case (.biometryNotAvailable, LABiometryType.touchID),
                     (.biometryNotEnrolled, LABiometryType.touchID):
                    return .notAvailable(.touchID)
                default:
                    return .none
                }
            } else {
                switch code {
                case .touchIDLockout:
                    return .lockedOut(.touchID)
                case .touchIDNotEnrolled, .touchIDNotAvailable:
                    return .notAvailable(.touchID)
                default:
                    return .none
                }
            }
        }

        return .none
    }
}
