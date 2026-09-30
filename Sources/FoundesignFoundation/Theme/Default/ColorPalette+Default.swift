import SwiftUI

extension ColorPalette {
  public static let `default` = ColorPalette(
    gray: .init(
      `0`: .adaptive(light: 0xFFFFFF, dark: 0x000000),
      `100`: .adaptive(light: 0xF7F8F9, dark: 0x16171B),
      `200`: .adaptive(light: 0xF3F4F5, dark: 0x1D2025),
      `300`: .adaptive(light: 0xEEEFF1, dark: 0x2B2E35),
      `400`: .adaptive(light: 0xDCDEE3, dark: 0x393D46),
      `500`: .adaptive(light: 0xD1D3D8, dark: 0x5B606A),
      `600`: .adaptive(light: 0xB0B3BA, dark: 0x868B94),
      `700`: .adaptive(light: 0x868B94, dark: 0xB0B3BA),
      `800`: .adaptive(light: 0x555D6D, dark: 0xDCDEE3),
      `900`: .adaptive(light: 0x2A3038, dark: 0xE9EAEC),
      `1000`: .adaptive(light: 0x1A1C20, dark: 0xF3F4F5)
    ),
    orange: .init(
      `100`: .adaptive(light: 0xFFF2EC, dark: 0x31241F),
      `200`: .adaptive(light: 0xFFE8DB, dark: 0x4B291C),
      `300`: .adaptive(light: 0xFFD5C0, dark: 0x6B311C),
      `400`: .adaptive(light: 0xFFB999, dark: 0x923600),
      `500`: .adaptive(light: 0xFF9364, dark: 0xBD4201),
      `600`: .adaptive(light: 0xFF6600, dark: 0xE65200),
      `700`: .adaptive(light: 0xE14D00, dark: 0xFF6600),
      `800`: .adaptive(light: 0xB93901, dark: 0xFF9E65),
      `900`: .adaptive(light: 0x862B00, dark: 0xEECEBC),
      `1000`: .adaptive(light: 0x471601, dark: 0xF4EEEA)
    ),
    blue: .init(
      `100`: .adaptive(light: 0xEFF6FF, dark: 0x202742),
      `200`: .adaptive(light: 0xE2EDFC, dark: 0x1E3352),
      `300`: .adaptive(light: 0xCBDFFA, dark: 0x1A4275),
      `400`: .adaptive(light: 0xAACEFD, dark: 0x0F559E),
      `500`: .adaptive(light: 0x85B8FD, dark: 0x1964D8),
      `600`: .adaptive(light: 0x5E98FE, dark: 0x1E82EB),
      `700`: .adaptive(light: 0x217CF9, dark: 0x41A2F9),
      `800`: .adaptive(light: 0x135FCD, dark: 0x83BCF9),
      `900`: .adaptive(light: 0x0B4596, dark: 0xB9D7FB),
      `1000`: .adaptive(light: 0x032451, dark: 0xE5F0FE)
    ),
    green: .init(
      `100`: .adaptive(light: 0xEDFAF6, dark: 0x202926),
      `200`: .adaptive(light: 0xD9F6E9, dark: 0x20362E),
      `300`: .adaptive(light: 0xB9E9D2, dark: 0x20493B),
      `400`: .adaptive(light: 0x7DDCB3, dark: 0x19604C),
      `500`: .adaptive(light: 0x42C593, dark: 0x117956),
      `600`: .adaptive(light: 0x10AB7D, dark: 0x1B946D),
      `700`: .adaptive(light: 0x079171, dark: 0x22B27F),
      `800`: .adaptive(light: 0x00745F, dark: 0x35CE9A),
      `900`: .adaptive(light: 0x075445, dark: 0x93E5C0),
      `1000`: .adaptive(light: 0x0A2B24, dark: 0xD4F6EF)
    ),
    yellow: .init(
      `100`: .adaptive(light: 0xFFF7DE, dark: 0x302819),
      `200`: .adaptive(light: 0xFDEFB9, dark: 0x413218),
      `300`: .adaptive(light: 0xFBDC65, dark: 0x543E15),
      `400`: .adaptive(light: 0xE9C647, dark: 0x714E15),
      `500`: .adaptive(light: 0xD4AB28, dark: 0x91601B),
      `600`: .adaptive(light: 0xC49725, dark: 0xB6720D),
      `700`: .adaptive(light: 0x9B7821, dark: 0xCA901C),
      `800`: .adaptive(light: 0x755B22, dark: 0xDAB156),
      `900`: .adaptive(light: 0x4F3E1F, dark: 0xE5D49B),
      `1000`: .adaptive(light: 0x2C2512, dark: 0xF7F0CD)
    ),
    red: .init(
      `100`: .adaptive(light: 0xFDF0F0, dark: 0x322323),
      `200`: .adaptive(light: 0xFDE7E7, dark: 0x4F2624),
      `300`: .adaptive(light: 0xFED4D2, dark: 0x742826),
      `400`: .adaptive(light: 0xFEB7B3, dark: 0xA12621),
      `500`: .adaptive(light: 0xFE928D, dark: 0xCA2319),
      `600`: .adaptive(light: 0xFC6A66, dark: 0xF73526),
      `700`: .adaptive(light: 0xFA342C, dark: 0xFF6E60),
      `800`: .adaptive(light: 0xCA1D13, dark: 0xFFA299),
      `900`: .adaptive(light: 0x921708, dark: 0xF8C5C3),
      `1000`: .adaptive(light: 0x4A1209, dark: 0xFDF2F2)
    ),
    purple: .init(
      `100`: .adaptive(light: 0xF5F3FE, dark: 0x28213B),
      `200`: .adaptive(light: 0xEFEAFE, dark: 0x3B2873),
      `300`: .adaptive(light: 0xE1D8FF, dark: 0x443081),
      `400`: .adaptive(light: 0xD0C0FF, dark: 0x5A3BB1),
      `500`: .adaptive(light: 0xB8A1FF, dark: 0x764FD9),
      `600`: .adaptive(light: 0x9F84FB, dark: 0x8E6BEE),
      `700`: .adaptive(light: 0x8969EA, dark: 0xA78DF0),
      `800`: .adaptive(light: 0x6D50CB, dark: 0xBEADF2),
      `900`: .adaptive(light: 0x50379B, dark: 0xD9CEFA),
      `1000`: .adaptive(light: 0x29175D, dark: 0xF0EDFC)
    ),
    black: .adaptive(light: 0x000000, dark: 0x000000),
    white: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF),
    blackAlpha: .init(
      `100`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 7.0 / 255.0),
      `200`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 12.0 / 255.0),
      `300`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 16.0 / 255.0),
      `400`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 33.0 / 255.0),
      `500`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 44.0 / 255.0),
      `600`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 76.0 / 255.0),
      `700`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 116.0 / 255.0),
      `800`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 162.0 / 255.0),
      `900`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 208.0 / 255.0),
      `1000`: .adaptive(light: 0x000000, dark: 0x000000, lightOpacity: 227.0 / 255.0)
    ),
    whiteAlpha: .init(
      `50`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 13.0 / 255.0),
      `100`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 23.0 / 255.0),
      `200`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 32.0 / 255.0),
      `300`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 46.0 / 255.0),
      `400`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 61.0 / 255.0),
      `500`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 96.0 / 255.0),
      `600`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 139.0 / 255.0),
      `700`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 179.0 / 255.0),
      `800`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 222.0 / 255.0),
      `900`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 234.0 / 255.0),
      `1000`: .adaptive(light: 0xFFFFFF, dark: 0xFFFFFF, lightOpacity: 244.0 / 255.0)
    )
  )
}
