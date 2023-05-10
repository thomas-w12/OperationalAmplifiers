//


import Foundation
import SwiftUI

public struct FontHelper {
    public static func registerFonts() {
        
        registerFont(bundle: .main, fontName: "Orbitron-Bold", fontExtension: "ttf")
        registerFont(bundle: .main, fontName: "Quicksand-Bold", fontExtension: "ttf")
        registerFont(bundle: .main, fontName: "Quicksand-SemiBold", fontExtension: "ttf")
        registerFont(bundle: .main, fontName: "Quicksand-Regular", fontExtension: "ttf")
        registerFont(bundle: .main, fontName: "Quicksand-Medium", fontExtension: "ttf")
        registerFont(bundle: .main, fontName: "Quicksand-Light", fontExtension: "ttf")
        
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
        
    }
    
}
