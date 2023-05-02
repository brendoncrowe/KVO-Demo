//
//  Settings.swift
//  KVO-Demo
//
//  Created by Brendon Crowe on 5/2/23.
//

import Foundation

@objc class Settings: NSObject {
    static var shared = Settings()
    @objc dynamic var fontSize: Int
    @objc dynamic var iconName: String
    
    override private init() {
        fontSize = 17
        iconName = "sun.haze.fill"
    }
}
