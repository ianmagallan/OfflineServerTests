//
//  OfflineServerTests.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 25/12/20.
//

import XCTest
@testable import OfflineServer

class OfflineServerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBeforePostRequest() {
        /* Arrange */
        let username = "testuser"
        let password = "hello"
        let mockNetworkLayer = MockNetworkLayer()
        let mockEncryptionHelper = MockEncryptionHelper()
        
        let exp = expectation(description: "Post request completed")
        
        
        /* Act */
        let requestHelper = RegistrationRequestHelper(networkLayer: mockNetworkLayer, encryptionHelper: mockEncryptionHelper)
        requestHelper.register(username, password: password) { (result) in
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        
        /* Assert */
        let expectedUrl = URL(string: "https://some-api-call.com")!
        let actualUrl = mockNetworkLayer.postUrl
        XCTAssertEqual(actualUrl, expectedUrl)
        
        XCTAssertTrue(mockEncryptionHelper.encryptionCalled)
        
        let encryptedPassword = mockEncryptionHelper.encrypt(password)
        
        var expectedRequestJson = """
        {
            "username": "\(username)",
            "password": "\(encryptedPassword)"
        }
        """
        expectedRequestJson.trimJSON()
        
        let actualRequestData = mockNetworkLayer.requestData
        let actualRequestJson = String(data: actualRequestData, encoding: .utf8)!
        XCTAssertEqual(expectedRequestJson, actualRequestJson)
    }
    
    func testParseUserObject() {
        /* Arrange */
        let stubNetworkLayer = StubSuccessNetworkLayer()
        let dummyEncryption = DummyEncryptionHelper()
        
        let exp = expectation(description: "Post request completed")
        
        /* Act */
        var postResult: Result<User, RegistrationRequestError>!
        
        let requestHelper = RegistrationRequestHelper(networkLayer: stubNetworkLayer, encryptionHelper: dummyEncryption)
        requestHelper.register("john", password: "dummy-password") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        /* Assert */
        let actualUser = try? postResult.get()
        let expectedUser = User(userId: 1001, username: "john")
        
        XCTAssertEqual(expectedUser.userId, actualUser?.userId)
        
        XCTAssertEqual(expectedUser.username, actualUser?.username)
        
        XCTAssertNil(actualUser?.email)
        XCTAssertNil(actualUser?.phone)
    }
    
    func testUsernameAlreadyExists() {
        /* Arrange */
        let stubNetworkLayer = StubUsernameExistNetworkLayer()
        let dummyEncryptionHelper = DummyEncryptionHelper()
        
        let exp = expectation(description: "Post request completed")
        
        var postResult: Result<User, RegistrationRequestError>!
        
        let requestHelper = RegistrationRequestHelper(networkLayer: stubNetworkLayer, encryptionHelper: dummyEncryptionHelper)
        requestHelper.register("dummy-username", password: "dummy-password") { (result) in
            postResult = result
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        /* Assert */
        var actualError: RegistrationRequestError?
        XCTAssertThrowsError(try postResult.get()) { (error) in
            actualError = error as? RegistrationRequestError
        }
        
        let expectedError = RegistrationRequestError.usernameAlreadyExists
        XCTAssertEqual(expectedError, actualError)
    }
}

extension String {
    mutating func trimJSON() {
        self = self.replacingOccurrences(of: "\n", with: "")
        self = self.replacingOccurrences(of: " ", with: "")
    }
}
