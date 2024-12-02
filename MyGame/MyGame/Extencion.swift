import Foundation

extension Dictionary {
    static func loadJSONFromBundle(filename: String) -> Dictionary<String, AnyObject>? {
        // Проверка на допустимость пути
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
            print("Could not find file: \(filename).json in bundle")
            return nil
        }

        do {
            // Чтение данных из файла
            let data = try Data(contentsOf: URL(fileURLWithPath: path))

            // Попытка десериализации JSON
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                return dictionary
            } else {
                print("JSON формат файла \(filename) неверный или имеет неправильную структуру")
                return nil
            }
        } catch {
            print("Error loading or parsing \(filename).json: \(error)")
            return nil
        }
    }
}
