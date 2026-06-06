//
//  AppConstants.swift
//  tumi
//
//  Created by Julian Garcia-Haugland on 5/21/26.
//1111

// Color+Hex.swift
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (no alpha)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (with alpha)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red:     Double(r) / 255,
            green:   Double(g) / 255,
            blue:    Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Color{
    static let primarybrown = Color(hex:"#E6D2B5")
    static let lightbrownbkgrnd = Color(hex: "#F6EDDF")
    static let accentorange = Color(hex: "#C96F29")
    static let darkbrownimpactfont = Color(hex: "#2E1A0F")
    static let secondaryfont = Color(hex: "#7A4F2A")
    static let brownfont = Color(hex: "#4A2E1A").opacity(1)
    static let mutedgray =  Color(hex: "A69B94")
}
    
