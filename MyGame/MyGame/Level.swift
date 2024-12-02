//  Level.swift
//  MyGame
//
//  Created by apple on 5.11.24.
//

import Foundation

let NumColumns = 9
let NumRows = 9

class Level {
    fileprivate var cookies = Array2D<Cookie>(columns: NumColumns, rows: NumRows)

        init(filename: String) {
            guard let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle(filename: filename) else {
                print("Ошибка при загрузке уровня: \(filename)")
                return
            }

            guard let tilesArray = dictionary["tiles"] as? [[Int]] else {
                print("Ошибка: не удалось найти 'tiles' в JSON файле.")
                return
            }
            print("Загружен словарь: \(dictionary)")

            print("Загружены данные уровня: \(tilesArray)")

            for (row, rowArray) in tilesArray.enumerated() {
                let tileRow = NumRows - row - 1
                for (column, value) in rowArray.enumerated() {
                    if value == 1 {
                        tiles[column, tileRow] = Tile()
                    }
                }
            }
        }
    private var tiles = Array2D<Tile>(columns: NumColumns, rows: NumRows)

    func tileAt(column: Int, row: Int) -> Tile? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return tiles[column, row]
    }
    // Получить печенье по индексу
    func cokieAt(column: Int, row: Int) -> Cookie? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return cookies[column, row]
    }

    // Перемешать печеньки (создать начальные печенья)
    func shuffle() -> Set<Cookie> {
        return createInitialCookies() // Исправлено название функции
    }

    // Создать начальные печенья
    private func createInitialCookies() -> Set<Cookie> {
        var set = Set<Cookie>()
        for row in 0 ..< NumRows {
            for column in 0 ..< NumColumns {
                if tiles[column, row] != nil {
                    let cookieType = CookieType.random()
                    let cookie = Cookie(column: column, row: row, cookieType: cookieType)
                    cookies[column, row] = cookie
                    set.insert(cookie)

                    // Печать информации о созданном печенье
                    print("Создано печенье: \(cookie) с типом \(cookie.cookieType) в позиции \(column), \(row)")
                }
            }
        }
        return set
    }


}
