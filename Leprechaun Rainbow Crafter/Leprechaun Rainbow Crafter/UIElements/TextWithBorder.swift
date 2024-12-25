struct TextWithBorder: View {
    let text: String
    let font: Font
    let textColor: Color
    let borderColor: Color
    let borderWidth: CGFloat

    var body: some View {
        ZStack {
            // Multiple layers of text for the border effect
//            ForEach([1, 1], id: \.self) { xOffset in
//                ForEach([1, 1], id: \.self) { yOffset in
//                    Text(text)
//                        .font(font)
//                        .foregroundColor(borderColor)
//                        .offset(x: CGFloat(xOffset) * borderWidth, y: CGFloat(yOffset) * borderWidth)
//                }
//            }
//            .offset(x: 1, y: 1)
//            // Main text layer
            Text(text)
                .font(font)
                .foregroundColor(textColor)
                .glowBorder(color: borderColor, lineWidth: 5)
            
            
        }
    }
}
   
    
//.offset(x: -2, y: 2)

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}
