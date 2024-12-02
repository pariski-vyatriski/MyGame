import SpriteKit

enum CookieType: Int, CustomStringConvertible {
    case unknown = 0, croissant, cuocake, danish, donur, macaroon, sugarCookie

    var spriteName: String {
        let spriteNames = [
            "Croissant",
            "Cupcake",
            "Danish",
            "Donut",
            "Macaroon",
            "SugarCookie",
        ]
        guard rawValue > 0, rawValue <= spriteNames.count else {
            return "Unknown"  // Возвращаем дефолтное значение для unknown
        }
        return spriteNames[rawValue - 1]
    }

    var highlightedSpriteName: String {
        return spriteName + "-Highlighted"
    }

    static func random() -> CookieType {
        let randomValue = Int.random(in: 1...6)
        return CookieType(rawValue: randomValue)!
    }
    var description: String {
        return spriteName
    }
    
}

class Cookie: CustomStringConvertible, Hashable {
    var column: Int
    var row: Int
    var cookieType: CookieType
    var sprite: SKSpriteNode?

    init(column: Int, row: Int, cookieType: CookieType, sprite: SKSpriteNode? = nil) {
        self.column = column
        self.row = row
        self.cookieType = cookieType
        self.sprite = sprite
    }

    var description: String {
        return "type: \(cookieType) (\(cookieType.rawValue)) square: (\(column), \(row))"
    }

    var hashValue: Int {
        return row*10 + column
    }
    static func == (lhs: Cookie, rhs: Cookie) -> Bool {
        return lhs.column == rhs.column && lhs.row == rhs.row
    }


}
