import Foundation

extension ColorToken {
  public static let `default` = ColorToken(palette: .default)
}

extension ColorToken.Foreground {
  public static let `default` = ColorToken.default.foreground
}

extension ColorToken.Background {
  public static let `default` = ColorToken.default.background
}

extension ColorToken.Border {
  public static let `default` = ColorToken.default.border
}
