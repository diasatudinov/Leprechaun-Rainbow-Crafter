//
//  DeviceInfo.swift
//  Leprechaun Rainbow Crafter
//
//  Created by Dias Atudinov on 25.12.2024.
//


import UIKit

class DeviceInfo {
    static let shared = DeviceInfo()
    
    var deviceType: UIUserInterfaceIdiom
    
    private init() {
        self.deviceType = UIDevice.current.userInterfaceIdiom
    }
}