//
//  TextManager.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import SwiftUI

final class FontManager {

    enum Weight {
        case regular, medium, semibold, bold, extrabold

        var base: String {
            return "AppleSDGothicNeo"
        }

        var strVal: String {
            switch self {
            case .regular:
                return base + "-Regular"
            case .medium:
                return base + "-Medium"
            case .semibold:
                return base + "-SemiBold"
            case .bold:
                return base + "-Bold"
            case .extrabold:
                return base + "-ExtraBold"
            }
        }
    }
    
    static func font(size: CGFloat, weight: Weight) -> Font {
        return Font.custom(weight.strVal, size: size)
    }

}
