//
//  TrophyConfiguration.swift
//  TrophyKit
//
//  Created by Yubo Qin on 6/30/21.
//

import UIKit

public struct TrophyConfiguration {

    /// Enum for sizes of a trophy banner.
    public enum TrophySize {
        case small
        case medium
        case large
    }

    public static let defaultLightColor = UIColor(red: 75/255, green: 180/255, blue: 27/255, alpha: 1.0)
    public static let defaultDarkColor = UIColor(red: 15/255, green: 114/255, blue: 15/255, alpha: 1.0)

    public let lightColor: UIColor
    public let darkColor: UIColor
    public let size: TrophySize

    /// Creates a configuration struct.
    /// - Parameters:
    ///   - lightColor: The color of the ball.
    ///   - darkColor: The color of the banner.
    ///   - size: Size of the trophy banner.
    public init(lightColor: UIColor = TrophyConfiguration.defaultLightColor,
                darkColor: UIColor = TrophyConfiguration.defaultDarkColor,
                size: TrophySize = .medium) {
        self.lightColor = lightColor
        self.darkColor = darkColor
        self.size = size
    }

}
