//
//  LoginView.swift
//  Dialector
//
//  Created by Meet  on 4/23/24.
//

import Foundation
// LoginView.swift
import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool

    var body: some View {
        Button("Log In") {
            isLoggedIn = true
        }
        .padding()
    }
}
