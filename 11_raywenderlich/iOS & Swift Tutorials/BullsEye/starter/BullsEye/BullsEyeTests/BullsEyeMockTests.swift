import XCTest
@testable import BullsEye

class MockUserDefaults: UserDefaults {
  var gameStyleChanged = 0  // Boolではなく柔軟に使用するためIntを今回使う
  override func set(_ value: Int, forKey defaultName: String) {
    if defaultName == "gameStyle" {
      gameStyleChanged += 1
    }
  }
}

final class BullsEyeMockTests: XCTestCase {
  
  var sut: ViewController!
  var mockUserDefaults: MockUserDefaults!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ViewController

    mockUserDefaults = MockUserDefaults(suiteName: "testing")
    sut.defaults = mockUserDefaults
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockUserDefaults = nil
    try super.tearDownWithError()
  }
  
  // MARK: - Test
  
  func testGameStyleCanBeChanged() {
    // given
    let segmentedControl = UISegmentedControl()
        
    // when
    XCTAssertEqual(
      mockUserDefaults.gameStyleChanged,
      0,
      "gameStyleChanged should be 0 before sendActions")
    
    segmentedControl.addTarget(
      sut,
      action: #selector(ViewController.chooseGameStyle(_:)),
      for: .valueChanged)
    segmentedControl.sendActions(for: .valueChanged)
    
    // then
    XCTAssertEqual(
      mockUserDefaults.gameStyleChanged,
      1,
      "gameStyle user default wasn't changed")
  }
  
}
