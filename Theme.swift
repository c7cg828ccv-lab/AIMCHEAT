import SwiftUI

enum AIMTheme {
    static let blue = Color(red: 0.13, green: 0.43, blue: 0.88)
    static let ink = Color(red: 0.10, green: 0.17, blue: 0.27)
    static let muted = Color(red: 0.43, green: 0.51, blue: 0.62)
    static let background = Color(red: 0.96, green: 0.975, blue: 0.995)
}

struct BrandMark: View {
    var size: CGFloat = 74
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.3)
                .fill(LinearGradient(colors: [AIMTheme.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text("AC").font(.system(size: size * 0.34, weight: .heavy, design: .rounded)).foregroundStyle(.white)
        }
        .frame(width: size, height: size)
        .shadow(color: AIMTheme.blue.opacity(0.2), radius: 12, y: 6)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.font(.system(size: 15, weight: .bold, design: .rounded))
            .foregroundStyle(.white).frame(maxWidth: .infinity, minHeight: 52)
            .background(AIMTheme.blue.opacity(configuration.isPressed ? 0.78 : 1), in: RoundedRectangle(cornerRadius: 16))
    }
}
