
import Foundation
import RealmSwift

class IngredientDB: Object {
  @objc dynamic var id = 0
  @objc dynamic var title = ""
  @objc dynamic var notes = ""
  @objc dynamic var quantity = 1
  @objc dynamic var bought = false
  @objc dynamic var colorName = "rw-green"

  override static func primaryKey() -> String? {
    "id"
  }
}
