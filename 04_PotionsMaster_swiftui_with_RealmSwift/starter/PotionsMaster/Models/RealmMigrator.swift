import Foundation
import RealmSwift

enum RealmMigrator {
  // 1
  static private func migrationBlock(
    migration: Migration,
    oldSchemaVersion: UInt64
  ) {
    // 2
    if oldSchemaVersion < 1 {
      // 3
      migration
        .enumerateObjects(ofType: IngredientDB.className()) { _, newObject in
          newObject?["colorName"] = "rw-green"
        }
    }
  }
  
  static func setDefaultConfiguration() {
    // 1
    let config = Realm.Configuration(
      schemaVersion: 1,
      migrationBlock: migrationBlock)
    // 2
    Realm.Configuration.defaultConfiguration = config
  }
}
