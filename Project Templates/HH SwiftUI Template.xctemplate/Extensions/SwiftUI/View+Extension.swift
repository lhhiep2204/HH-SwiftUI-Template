//___FILEHEADER___

import SwiftUI

public extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Border

/// A view modifier that adds a border with a specified corner radius, border color, and line width to any view.
struct CustomBorder: ViewModifier {
    let cornerRadius: CGFloat
    let borderColor: Color
    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .cornerRadius(cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: lineWidth)
            }
    }
}

public extension View {
    /// Adds a border with a specified corner radius, border color, and line width to the view.
    ///
    /// - Parameters:
    ///   - radius: The radius of the border's corners. Default is 8.
    ///   - color: The color of the border. Default is clear.
    ///   - lineWidth: The width of the border line. Default is 0.
    ///
    /// - Returns: A view with the specified border applied.
    func border(radius: CGFloat = 8,
                color: Color = .clear,
                lineWidth: CGFloat = 0) -> some View {
        modifier(CustomBorder(cornerRadius: radius,
                              borderColor: color,
                              lineWidth: lineWidth))
    }
}

// MARK: - Shadow

/// A view modifier that adds a shadow with specified properties to any view.
struct CustomShadow: ViewModifier {
    var shadowRadius: CGFloat
    var shadowColor: Color
    var posX: CGFloat
    var posY: CGFloat

    func body(content: Content) -> some View {
        content
            .shadow(color: shadowColor, radius: shadowRadius, x: posX, y: posY)
    }
}

public extension View {
    /// Adds a shadow with specified properties to the view.
    ///
    /// - Parameters:
    ///   - radius: The blur radius of the shadow. Default is 8.
    ///   - color: The color of the shadow. Default is gray.
    ///   - posX: The horizontal offset of the shadow. Default is 3.
    ///   - posY: The vertical offset of the shadow. Default is 3.
    ///
    /// - Returns: A view with the specified shadow applied.
    func shadow(radius: CGFloat = 8,
                color: Color = .gray,
                posX: CGFloat = 3,
                posY: CGFloat = 3) -> some View {
        modifier(CustomShadow(shadowRadius: radius,
                              shadowColor: color,
                              posX: posX,
                              posY: posY))
    }
}
