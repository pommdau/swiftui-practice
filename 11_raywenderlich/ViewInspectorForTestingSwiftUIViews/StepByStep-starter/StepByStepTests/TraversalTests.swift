import XCTest
import SwiftUI
import ViewInspector

struct AmbiguousView: View, Inspectable {
  var body: some View {
    VStack {
      HStack {
        Button("Ray") {}
          .id(1)
      }
      Button("Ray") {}
        .id(2)
    }
  }
}

class TraversalTests: XCTestCase {
  func testBreadthFirst() throws {
    let view = AmbiguousView()
    let button = try view.inspect().find(button: "Ray")
    XCTAssertEqual(try button.id(), 2)
  }
  
  func testDepthFirst() throws {
    let view = AmbiguousView()
    let button = try view.inspect().find(
      ViewType.Button.self,
      traversal: .depthFirst  // .depthFirst
    ) { button in
      // 1
      let text = try button.find(text: "Ray")
      // 2
      return (try? text.find(ViewType.Button.self, relation: .parent)) != nil
    }
    XCTAssertEqual(try button.id(), 1)
  }

}
