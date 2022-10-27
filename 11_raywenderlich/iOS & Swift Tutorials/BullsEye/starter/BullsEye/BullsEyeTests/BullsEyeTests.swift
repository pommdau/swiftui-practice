import XCTest
@testable import BullsEye

final class BullsEyeTests: XCTestCase {
  
  var sut: BullsEyeGame!  // system under test
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = BullsEyeGame()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
      
  func testScoreIsComputedWhenGuessIsHigherThanTarget() {
    // given
    let guess = sut.targetValue + 5  // 50 + 5 = 55
    
    // when
    sut.check(guess: guess)  // 55(guess) - 50(targetValue)=5, 100-5=95点が期待値
    
    // then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
  
  func testScoreIsComputedWhenGuessIsLowerThanTarger() {
    // given
    let guess = sut.targetValue - 5
    
    // when
    sut.check(guess: guess)
    
    // then
    XCTAssertEqual(sut.scoreRound, 95, "Score computed from guess is wrong")
  }
  
}
