//
//  ShiftezApp.swift
//  Shiftez
//
//  Created by Daniel Ivanov on 25/04/22.
//

import SwiftUI

@main
struct ShiftezApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView().frame(width: 0, height: 0)
        }
    }
}
