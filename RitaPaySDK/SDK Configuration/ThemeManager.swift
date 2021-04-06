//
//  ThemeManager.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation
import UIKit

/// Theme manager where you can set the theme properties of the SDK
public class ThemeManager {
    /// Singelton to access theme properties
    public static let shared = ThemeManager()
    
    public var themeColor: UIColor = UIColor(red: 92/255, green: 186/255, blue: 188/255, alpha: 1)
    public var companyLogoImage: UIImage? = nil
}
