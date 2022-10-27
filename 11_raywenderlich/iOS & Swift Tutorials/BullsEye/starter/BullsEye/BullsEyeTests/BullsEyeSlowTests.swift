import XCTest
@testable import BullsEye


final class BullsEyeSlowTests: XCTestCase {
  
  var sut: URLSession!
  
  // 他でも使えそうな便利なWrapper。
  // providing a convenient way to check for a network connection.
  let networkMonitor = NetworkMonitor.shared
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = URLSession(configuration: .default)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testValidApiCallGetsHTTPStatusCode200() throws {
    
    // ネットワークが使えない場合はテストをスキップ
    try XCTSkipUnless(
      networkMonitor.isReachable, "Network connectivity needed for this test."
    )
    
    // given
    let urlString = "http://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
//    let urlString = "http://www.randomnumberapi.com/test"  // DEBUG for fail
    let url = URL(string: urlString)!
    let promise = expectation(description: "Completion handler invoked")
    var statusCode: Int?
    var responseError: Error?
    
    // when
    let dataTask = sut.dataTask(with: url) { _, response, error in
      statusCode = (response as? HTTPURLResponse)?.statusCode
      responseError = error
      promise.fulfill()
    }
    dataTask.resume()
    wait(for: [promise], timeout: 5)
    
    // then
    // 非同期処理を終わらせてから結果を確認することで、待ち時間を短縮する
    XCTAssertNil(responseError)  // errorがあればFail
    XCTAssertEqual(statusCode, 200)
  }
}
