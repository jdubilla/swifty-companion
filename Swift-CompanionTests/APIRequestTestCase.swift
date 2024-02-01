//
//  APIRequestTestCase.swift
//  Swift-CompanionTests
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import XCTest

final class APIRequestTestCase: XCTestCase {
    
    var apiRequest: APIRequest!
    var token: ApiToken = ApiToken(access_token: "", created_at: 111111111111111111, expires_in: 11111111111111, refresh_token: "abc")
    let validUsername = "jdubilla"
    let invalidUsername = "dfjkhgdkf"
    
    override func setUp() {
        super.setUp()
        apiRequest = APIRequest(token: token)
    }
    
    override func tearDown() {
        apiRequest = nil
        super.tearDown()
    }
    
    func testUserData() async throws {
        let user = try await apiRequest.userData(username: validUsername)
        XCTAssertNotNil(user, "User should not be nil")
        sleep(1)
    }
    
    func testCoalitionsData() async throws {
        do {
            let coalitions: [Coalition]? = try await apiRequest.coalitionsData(username: validUsername)
            XCTAssertNotNil(coalitions, "Coalitions should not be nil")
        } catch {
            XCTFail("Error fetching coalitions: \(error.localizedDescription)")
        }
        sleep(1)
    }
    
    func testLocationsUser() async throws {
        let locations = try await apiRequest.locationsUser(username: validUsername)
        XCTAssertNotNil(locations, "Locations should not be nil")
        sleep(1)
    }
    
    func testFetchDataUser() async throws {
        await apiRequest.fetchDataUser(username: validUsername)
        XCTAssertTrue(apiRequest.isFinish, "Fetching data should finish")
        XCTAssertNotNil(apiRequest.user, "User should not be nil")
        XCTAssertNotNil(apiRequest.coalitions, "Coalitions should not be nil")
        XCTAssertNotNil(apiRequest.locations, "Locations should not be nil")
        sleep(1)
    }
    
    func testFetchDataUserWithError() async throws {
        await apiRequest.fetchDataUser(username: invalidUsername)
        XCTAssertNil(apiRequest.user, "User should be nil for an invalid username")
        XCTAssertFalse(apiRequest.isFinish, "Fetching data should not finish for an invalid username")
    }
}


struct ApiTokenBis: Decodable {
    var access_token: String
    var token_type: String
    var expires_in: Int
    var scope: String
    var created_at: Int
}
