import XCTest
@testable import BullsEye


final class BullsEyeSlowTests: XCTestCase {
  
  var sut: URLSession!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = URLSession(configuration: .default)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testValidApiCallGetsHTTPStatusCode200() {
    // given
//    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
    let urlString = "http://www.randomnumberapi.com/test"  // DEBUG
    let url = URL(string: urlString)!
    
    let promise = expectation(description: "Status code: 200")
    
    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      // then
      if let error = error {
        XCTFail("Error: \(error.localizedDescription)")
        return
      } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
        if statusCode == 200 {
          promise.fulfill()
        } else {
          XCTFail("Status code: \(statusCode)")
        }
      }
    }
    
    dataTask.resume()
    wait(for: [promise], timeout: 5)
  }
  
}
