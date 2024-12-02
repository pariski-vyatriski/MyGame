import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var scene: GameScene!
    var level: Level!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Инициализация основного представления
        if let view = self.view as! SKView? {
            view.isMultipleTouchEnabled = false  // Отключение многопользовательского ввода
            view.ignoresSiblingOrder = true  // Улучшение производительности
            view.showsFPS = true  // Показ FPS для отладки
            view.showsNodeCount = true  // Показ количества узлов для отладки

            // Загружаем уровень и передаем его в GameScene
            level = Level(filename: "Level_1")  // Загрузка уровня
            scene = GameScene(size: view.bounds.size, level: level)  // Передача уровня в сцену
            scene.scaleMode = .aspectFill
            scene.addTiles()
            view.presentScene(scene)  // Отображение сцены

            // Печатаем в консоль, чтобы убедиться, что сцена была добавлена
            print("Scene presented")
        }
    }

    // Функция начала игры
    func beginGame() {
        shuffle()
    }

    // Перемешиваем печенья (начальная настройка уровня)
    func shuffle() {
        let newCookies = level.shuffle()  // Получаем новые случайные печенья
        scene.addSprite(for: newCookies)  // Добавляем их на экран
    }

    // Настройка ориентации экрана
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

    // Скрытие строки состояния
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
