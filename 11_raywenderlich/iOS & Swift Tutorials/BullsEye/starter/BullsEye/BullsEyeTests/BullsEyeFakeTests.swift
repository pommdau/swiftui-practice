import XCTest
@testable import BullsEye

final class BullsEyeFakeTests: XCTestCase {
  
  var sut: BullsEyeGame!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = BullsEyeGame()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testStartNewRoundUsesRandomValueFromApiRequest() {
    
    // given
    let stubbedData = "[1]".data(using: .utf8)
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let url = URL(string: urlString)!
    
    let stubbedResponse = HTTPURLResponse(
      url: url,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil)
    
    let urlSessionStub = URLSessionStub(
      data: stubbedData,
      response: stubbedResponse,
      error: nil)
    
    sut.urlSession = urlSessionStub
    let promise = expectation(description: "Value Received")
    
    // when
    sut.startNewRound {
      // then
      XCTAssertEqual(self.sut.targetValue, 1)
      promise.fulfill()
    }
    wait(for: [promise], timeout: 5)
  }
}
