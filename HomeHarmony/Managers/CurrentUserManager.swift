//
//  CurrentUserManager.swift
//  CleaningADHD
//
//  Created by Rachel Culligan on 6/25/26.
//

import Foundation
import Observation

@Observable
class CurrentUserManager {

    var currentUserName: String = "Me"

    func switchUser(to name: String) {
        currentUserName = name
    }
}
