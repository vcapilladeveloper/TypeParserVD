import XCTest
@testable import TypeParserVD

final class TypeParserVDTests: XCTestCase {
    
    var users: [User]!
    var firstUser: User!
    
    /*
     NSCoderReadCorruptError NS_ENUM_AVAILABLE(10 _11 9 _0)= 4864 / / Parsing error parsing data
     NSCoderValueNotFoundError NS_ENUM_AVAILABLE(10 _11 9 _0)= 4865 / /The data request file does not exist
     
     */
    
    override func setUp() {
        super.setUp()
        firstUser = User(id: 1,
                         name: "Leanne Graham",
                         username: "Bret",
                         email: "Sincere@april.biz",
                         phone: "1-770-736-8031 x56442",
                         website: "hildegard.org")
        users = []
    }
    
    override func tearDown() {
        firstUser = nil
        users = nil
        super.tearDown()
    }
    
    func manageModel() throws {
        let data = Data(usersJson.utf8)
        users = try TypeParserVD.getData(from: data)
    }
    
    func manageModelWithResult<T: Codable>() -> Result<T, DecodingError> {
        let data = Data(usersJson.utf8)
        return TypeParserVD.getData(from: data)
    }
    
    func test_givenValidJSON_completionWithUsers() throws {
        /// Given
        try manageModel()
        XCTAssertTrue(users.count > 0)
        XCTAssertEqual(users.first, firstUser)
    }
    
    func test_givenValidJSONWithResult_completionWithUsers() {
        /// Given
        let result: Result<[User], DecodingError> = manageModelWithResult()
        switch result {
        case .success(let users):
            self.users = users
        case .failure(_):
            XCTAssertTrue(false)
        }
        XCTAssertTrue(users.count > 0)
        XCTAssertEqual(users.first, firstUser)
    }
    
    func test_givenMissingValueJSON_completionWithError() {
        
        do {
            let data = Data(missingValueUsersJson.utf8)
            users = try TypeParserVD.getData(from: data)
        } catch {
            print(error.localizedDescription)
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it is missing.")
        }
    }
    
    func test_invalidTypeValueJSON_completionWithError() {
        
        do {
            let data = Data(invalidTypeUsersJson.utf8)
            users = try TypeParserVD.getData(from: data)
        } catch {
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }
    
    func test_getDataWithResult_givenMissingValueJSON_completionWithError() {
        let dataMissing = Data(missingValueUsersJson.utf8)
        let resultMissing: Result<[User], DecodingError> = TypeParserVD.getData(from: dataMissing)
        switch resultMissing {
        case .success(_):
            XCTAssertTrue(false)
        case .failure(let errorMissing):
            print(errorMissing.localizedDescription)
            XCTAssertEqual(errorMissing.localizedDescription, "The data couldn’t be read because it is missing.")
        }
    }
    
    func test_getDataWithResult_invalidTypeValueJSON_completionWithError() {
        let dataInvalid = Data(invalidTypeUsersJson.utf8)
        let resultType: Result<[User], DecodingError> = TypeParserVD.getData(from: dataInvalid)
        switch resultType {
        case .success(_):
            XCTAssertTrue(false)
        case .failure(let errorParsing):
            XCTAssertEqual(errorParsing.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }
}

