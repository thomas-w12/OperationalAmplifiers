//


import Foundation
import SwiftUI

class AppHelperClass {
    static let textFont = Font.custom("Quicksand-Medium", size: 24)
    static let smallTextFont = Font.custom("Quicksand-Medium", size: 18)
    static let boldedTextFont = Font.custom("Quicksand-Bold", size: 24)
    static let extraBoldedTextFont = Font.custom("Quicksand-Bold", size: 40)
    static let extraMegaBoldedTextFont = Font.custom("Quicksand-Bold", size: 60)
}

struct scrollViewTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(AppHelperClass.textFont)
            .opacity(0.8)
            .padding(.vertical, 10)
    }
}


struct scrollViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
    }
}


extension View {
    func scrollViewTextFormatted() -> some View {
        modifier(scrollViewTextModifier())
    }
    
    func scrollViewFormatted() -> some View {
        modifier(scrollViewModifier())
    }
    
}

extension AnyTransition {
    static var reverseSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }
}

extension AnyTransition {
    static var scrollSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .top)
        )
    }
}

extension AnyTransition {
    static var reverseScrollSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .top),
            removal: .move(edge: .bottom)
        )
    }
}



extension Array {
    func split() -> [[Element]] {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return [Array(leftSplit), Array(rightSplit)]
    }
}

extension View {

    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension Color {
    static let background = Color(UIColor.systemBackground)
}
