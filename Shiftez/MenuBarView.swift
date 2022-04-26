//
//  MenuBarView.swift
//  Shiftez
//
//  Created by Daniel Ivanov on 26/04/22.
//

import SwiftUI

struct MenuBarView: View {
    var body: some View {
        HStack(spacing: 4) {
            Image("menu-bar-icon")
        }
    }
}

struct MenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        MenuBarView()
            .padding(.horizontal, 5.0)
    }
}
