//
//  GitRepositoryTableViewCellTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import XCTest
@testable import GitTrending

final class GitRepositoryTableViewCellTests: XCTestCase {
    // MARK: - Private Properties
    var bundle: Bundle!
    var nib: UINib!
    var sut: GitRepositoryTableViewCell!
    
    override func setUp() {
        super.setUp()
        bundle = Bundle(for: GitRepositoryTableViewCell.self)
        nib = UINib(nibName: GitRepositoryTableViewCell.nibName, bundle: bundle)
        sut = nib.instantiate(withOwner: self, options: nil)[0] as? GitRepositoryTableViewCell
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        bundle = nil
        nib = nil
    }
    
    func testGitRepositoryTableViewCell_WhenLoaded_ShouldReturnCell() {
        //Assert
        XCTAssertNotNil(sut)
    }
    
    func testGitRepositoryTableViewCell_WhenLoads_ShouldHaveDefaultValues() throws {
        //Arrange
        let userNameLabel = try XCTUnwrap(sut.userNameLabel, "The userNameLabel IBOutlet should be connected")
        let repositoryNameLabel = try XCTUnwrap(sut.repositoryNameLabel, "The repositoryNameLabel IBOutlet should be connected")
        let repositoryLinkLabel = try XCTUnwrap(sut.repositoryLinkLabel, "The repositoryLinkLabel IBOutlet should be connected")
        let languageLabel = try XCTUnwrap(sut.languageLabel, "The languageLabel IBOutlet should be connected")
        let starCountLabel = try XCTUnwrap(sut.starCountLabel, "The starCountLabel IBOutlet should be connected")
        let profileImageView = try XCTUnwrap(sut.profileImageView, "The profileImageView IBOutlet should be connected")
        let starImageView = try XCTUnwrap(sut.starImageView, "The starImageView IBOutlet should be connected")
        let languageFlagView = try XCTUnwrap(sut.languageFlagView, "The languageFlagView IBOutlet should be connected")
        
        let startImageViewData =  try XCTUnwrap(starImageView.image?.pngData(), "starImageView data should not be nil the image should be assign")
        let startImageAssetData = try XCTUnwrap(UIImage(named: "star")?.pngData(), "Image should be in the assets")
        
        //Assert
        XCTAssertEqual(userNameLabel.text, "", "The fuserNameLabel not empty when the cell load")
        XCTAssertEqual(repositoryNameLabel.text, "", "The repositoryNameLabel not empty when the cell load")
        XCTAssertEqual(repositoryLinkLabel.text, "", "The repositoryLinkLabel not empty when the cell load")
        XCTAssertEqual(languageLabel.text, "", "The languageLabel not empty when the cell load")
        XCTAssertEqual(starCountLabel.text, "", "The starCountLabel not empty when the cell load")
        XCTAssertNil(profileImageView.image, "The profileImageView image is not nil cell load")
        XCTAssertEqual(startImageViewData, startImageAssetData, "The star image is not same")
        XCTAssertEqual(languageFlagView.backgroundColor, UIColor(named: "languageColor"), "The background color should be languageColor from asset")
        XCTAssertEqual(starImageView.tintColor, UIColor(named: "starColor"), "The tint color should be starColor")
    }
    
    func testGitRepositoryTableViewCell_WhenViewModelAssign_ShouldSetData() throws {
        //Arrange
        let repository = Repository(id: 1, name: "lambda", owner: Owner(id: 1, login: "lambda", avatarUrl: "www.google.com"), stars: 2, language: "swift", htmlURL: "www.googl.com")
        
        let userNameLabel = try XCTUnwrap(sut.userNameLabel, "The userNameLabel IBOutlet should be connected")
        let repositoryNameLabel = try XCTUnwrap(sut.repositoryNameLabel, "The repositoryNameLabel IBOutlet should be connected")
        let repositoryLinkLabel = try XCTUnwrap(sut.repositoryLinkLabel, "The repositoryLinkLabel IBOutlet should be connected")
        let languageLabel = try XCTUnwrap(sut.languageLabel, "The languageLabel IBOutlet should be connected")
        let starCountLabel = try XCTUnwrap(sut.starCountLabel, "The starCountLabel IBOutlet should be connected")
        
        //Act
        sut.viewModel = repository
        
        //Assert
        XCTAssertEqual(userNameLabel.text, repository.owner.login, "The userNameLabel text is not equal to the provided")
        XCTAssertEqual(repositoryNameLabel.text, repository.name, "The repositoryNameLabel text is not equal to the provided")
        XCTAssertEqual(repositoryLinkLabel.text, repository.htmlURL, "The repositoryLinkLabel text is not equal to the provided")
        XCTAssertEqual(languageLabel.text, repository.language, "The languageLabel text is not equal to the provided")
        XCTAssertEqual(starCountLabel.text, "\(repository.stars)", "The starCountLabel text is not equal to the provided")
    }
}
