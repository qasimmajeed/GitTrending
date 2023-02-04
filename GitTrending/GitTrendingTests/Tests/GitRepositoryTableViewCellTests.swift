//
//  GitRepositoryTableViewCellTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import XCTest
@testable import GitTrending

final class GitRepositoryTableViewCellTests: XCTestCase {
    
    func testGitRepositoryTableViewCell_WhenLoaded_ShouldReturnCell() {
        let bundle = Bundle(for: GitRepositoryTableViewCell.self)
        let nib = UINib(nibName: GitRepositoryTableViewCell.nibName, bundle: bundle)
        let sut = nib.instantiate(withOwner: self, options: nil)[0] as? GitRepositoryTableViewCell
        XCTAssertNotNil(sut)
    }
    
    func testGitRepositoryTableViewCellTests_WhenLoads_ShouldHaveDefaultValues() throws {
        let bundle = Bundle(for: GitRepositoryTableViewCell.self)
        let nib = UINib(nibName: GitRepositoryTableViewCell.nibName, bundle: bundle)
        let sut = nib.instantiate(withOwner: self, options: nil)[0] as! GitRepositoryTableViewCell
        
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

}
