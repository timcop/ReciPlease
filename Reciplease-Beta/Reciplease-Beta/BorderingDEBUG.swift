import SwiftUI

struct RandomBorder: ViewModifier {
    enum BColor {
        case fixedColor(color: Color)
        case randomColor
    }
    let bColor: BColor
    let width: CGFloat
    let outside:Bool
    func body( content:Content) -> some View {
        
        let borderColor: Color
        switch bColor {
        case .fixedColor(color: let color):
            borderColor = color
        case .randomColor:
            borderColor = Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
        }
        @ViewBuilder var body: some View {
            if outside {
                
                content
                    .padding(width)
                    .border(borderColor, width: width)
            } else {
                content
                .border(borderColor, width: width)
            }
        }
        
        return body
        
    }
}

extension View {
    func randomBorder(_ bgColor: RandomBorder.BColor = .randomColor, width: CGFloat = 2, outside: Bool = false) -> some View {
        self.modifier(RandomBorder(bColor: bgColor, width: width, outside: outside))
    }
}
