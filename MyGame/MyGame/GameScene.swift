import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var level: Level!  // Уровень игры
    let TileWidth: CGFloat = 32.0
    let TileHeight: CGFloat = 32.0  // Высота плитки
    let tilesLayer = SKNode()
    let gameLayer = SKNode()
    let cookiesLayer = SKNode()

    // Инициализация сцены с уровнем
    init(size: CGSize, level: Level) {
        self.level = level
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        // Устанавливаем фон
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = size
        addChild(background)
        let layerPosition = CGPoint(x: -TileWidth * CGFloat(NumColumns) / 2, y: -TileHeight * CGFloat(NumRows) / 2)
        cookiesLayer.position = layerPosition
        print("Cookies layer position: \(cookiesLayer.position)")

        // Добавляем игровые слои
        addChild(gameLayer)
        addChild(cookiesLayer) // Убедитесь, что cookiesLayer добавлен

        // Установим позиции слоев
        let NumColumns = 8
        let NumRows = 8

        cookiesLayer.position = layerPosition
        print("Cookies layer position: \(cookiesLayer.position)")
        tilesLayer.position = layerPosition
        gameLayer.addChild(tilesLayer)
        startLevel()  // Начинаем игру
    }

    func addTiles() {
            for row in 0 ..< NumRows {
                for column in 0 ..< NumColumns {
                    // Убедитесь, что tileAt работает корректно и возвращает объект, если на этой клетке есть тайл
                    if let tile = level.tileAt(column: column, row: row) {
                        let tilesNode = SKSpriteNode(imageNamed: "Tile")
                        tilesNode.size = CGSize(width: TileWidth, height: TileHeight)
                        tilesNode.position = pointFor(column: column, row: row)
                        tilesLayer.addChild(tilesNode)
                    }
                }
            }
        }

    // Функция для добавления спрайтов на экран
    // Функция для добавления спрайтов на экран
    // Функция для добавления спрайтов на экран
    func addSprite(for cookies: Set<Cookie>) {
        for cookie in cookies {
            let spriteName = cookie.cookieType.spriteName

            // Проверка, существует ли изображение
            if let _ = UIImage(named: spriteName) {
                // Если изображение найдено, создаем SKSpriteNode
                let sprite = SKSpriteNode(imageNamed: spriteName)
                sprite.size = CGSize(width: TileWidth, height: TileHeight)
                sprite.position = pointFor(column: cookie.column, row: cookie.row)
                cookiesLayer.addChild(sprite)
                cookie.sprite = sprite
                print("Position of cookie at \(sprite.position.x), \(sprite.position.y)")


                // Печать позиции спрайта для отладки
                print("cookie position: \(sprite.position)")
            } else {
                // Если изображение не найдено, выводим сообщение в консоль
                print("Изображение для \(spriteName) не найдено")
            }
        }
    }

    




    // Функция для вычисления позиции печенья по столбцу и ряду
    func pointFor(column: Int, row: Int) -> CGPoint {
        let xPosition = CGFloat(column) * TileWidth
        let yPosition = CGFloat(row) * TileHeight
        print("Calculated position for column \(column), row \(row): \(xPosition), \(yPosition)")
        return CGPoint(x: xPosition, y: yPosition)
    }

    // Функция для начала уровня
    func startLevel() {
        let cookies = level.shuffle()  // Получаем печенья для уровня
        addSprite(for: cookies)  // Добавляем их на экран
    }
}
