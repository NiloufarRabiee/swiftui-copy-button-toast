import XCTest
@testable import CopyButtonToast

final class CopyButtonToastTests: XCTestCase {
    func testValidToastDurationIsPreserved() {
        XCTAssertEqual(
            CopyButtonToastConfiguration.normalizedDuration(2),
            2,
            accuracy: 0.0001
        )
    }

    func testZeroDurationIsClamped() {
        XCTAssertEqual(
            CopyButtonToastConfiguration.normalizedDuration(0),
            CopyButtonToastConfiguration.minimumDuration,
            accuracy: 0.0001
        )
    }

    func testNegativeDurationIsClamped() {
        XCTAssertEqual(
            CopyButtonToastConfiguration.normalizedDuration(-1),
            CopyButtonToastConfiguration.minimumDuration,
            accuracy: 0.0001
        )
    }

    func testInfiniteDurationUsesFallback() {
        XCTAssertEqual(
            CopyButtonToastConfiguration.normalizedDuration(.infinity),
            CopyButtonToastConfiguration.fallbackDuration,
            accuracy: 0.0001
        )
    }

    func testNaNDurationUsesFallback() {
        XCTAssertEqual(
            CopyButtonToastConfiguration.normalizedDuration(.nan),
            CopyButtonToastConfiguration.fallbackDuration,
            accuracy: 0.0001
        )
    }
}
