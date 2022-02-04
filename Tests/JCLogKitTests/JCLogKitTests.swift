import XCTest
@testable import JCLogKit

final class JCLogKitTests: XCTestCase {
    func testDebugMode() {
        #if !DEBUG
        XCTFail()
        #endif
    }
}
