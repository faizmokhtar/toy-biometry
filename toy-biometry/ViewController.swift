//
//  ViewController.swift
//  toy-biometry
//
//  Created by Faiz Mokhtar on 13/05/2018.
//  Copyright © 2018 Faiz Mokhtar. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let biometrySupported = BiometricAuth().supportedBiometry
        switch biometrySupported {
        case .available(.faceID),
             .available(.touchID):
            handleLocalAuthentication()
        case .lockedOut:
            print("TouchID or FaceID locked out")
        case .notAvailable:
            print("TouchID or FaceID not available")
        case .none:
            print("TouchID or FaceID not supported")
        }
    }

    private func handleLocalAuthentication() {
        let localContext = LAContext()
        localContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                    localizedReason: "To access secure data")
        { success, evaluateError in
            if success {
                print("User authenticated successfully")
            } else {
                guard let error = evaluateError else { return }
                print("Error authenticating: \(error.localizedDescription)")
            }
        }
    }
}

