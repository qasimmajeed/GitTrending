//
//  GitRepositoryTableViewCellTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

@testable import GitTrending
import XCTest

final class GitRepositoryTableViewCellTests: XCTestCase {
    // MARK: - Private Properties

    var bundle: Bundle!
    var nib: UINib!
    var sut: GitRepositoryTableViewCell!
    var repository: Repository!
    var cellViewModel: GitRepositoryCellViewModel!

    override func setUp() {
        super.setUp()
        bundle = Bundle(for: GitRepositoryTableViewCell.self)
        nib = UINib(nibName: GitRepositoryTableViewCell.nibName, bundle: bundle)
        sut = nib.instantiate(withOwner: self, options: nil)[0] as? GitRepositoryTableViewCell
        repository = Repository(id: 1, name: "lambda", owner: Owner(id: 1, login: "lambda", avatarUrl: "www.google.com"), stars: 2, language: "swift", htmlURL: "www.googl.com")
        cellViewModel = GitRepositoryCellViewModel(repository: repository)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        bundle = nil
        nib = nil
        repository = nil
        cellViewModel = nil
    }

    func testGitRepositoryTableViewCell_WhenLoaded_ShouldReturnCell() {
        // Assert
        XCTAssertNotNil(sut)
    }

    func testGitRepositoryTableViewCell_WhenLoads_ShouldHaveDefaultValues() throws {
        // Arrange
        let userNameLabel = try XCTUnwrap(sut.userNameLabel, "The userNameLabel IBOutlet should be connected")
        let repositoryNameLabel = try XCTUnwrap(sut.repositoryNameLabel, "The repositoryNameLabel IBOutlet should be connected")
        let repositoryLinkLabel = try XCTUnwrap(sut.repositoryLinkLabel, "The repositoryLinkLabel IBOutlet should be connected")
        let languageLabel = try XCTUnwrap(sut.languageLabel, "The languageLabel IBOutlet should be connected")
        let starCountLabel = try XCTUnwrap(sut.starCountLabel, "The starCountLabel IBOutlet should be connected")
        let profileImageView = try XCTUnwrap(sut.profileImageView, "The profileImageView IBOutlet should be connected")
        let starImageView = try XCTUnwrap(sut.starImageView, "The starImageView IBOutlet should be connected")
        let languageFlagView = try XCTUnwrap(sut.languageFlagView, "The languageFlagView IBOutlet should be connected")

        let startImageViewData = try XCTUnwrap(starImageView.image?.pngData(), "starImageView data should not be nil the image should be assign")
        let startImageAssetData = try XCTUnwrap(UIImage(named: "star")?.pngData(), "Image should be in the assets")

        // Assert
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
        // Arrange
        let userNameLabel = try XCTUnwrap(sut.userNameLabel, "The userNameLabel IBOutlet should be connected")
        let repositoryNameLabel = try XCTUnwrap(sut.repositoryNameLabel, "The repositoryNameLabel IBOutlet should be connected")
        let repositoryLinkLabel = try XCTUnwrap(sut.repositoryLinkLabel, "The repositoryLinkLabel IBOutlet should be connected")
        let languageLabel = try XCTUnwrap(sut.languageLabel, "The languageLabel IBOutlet should be connected")
        let starCountLabel = try XCTUnwrap(sut.starCountLabel, "The starCountLabel IBOutlet should be connected")

        // Act
        sut.viewModel = cellViewModel

        // Assert
        XCTAssertEqual(userNameLabel.text, cellViewModel.userName, "The userNameLabel text is not equal to the provided")
        XCTAssertEqual(repositoryNameLabel.text, cellViewModel.repoName, "The repositoryNameLabel text is not equal to the provided")
        XCTAssertEqual(repositoryLinkLabel.text, cellViewModel.repoHtmlURl, "The repositoryLinkLabel text is not equal to the provided")
        XCTAssertEqual(languageLabel.text, cellViewModel.language, "The languageLabel text is not equal to the provided")
        XCTAssertEqual(starCountLabel.text, cellViewModel.starCount, "The starCountLabel text is not equal to the provided")
    }

    func testGitRepositoryTableViewCell_WhenLoads_PictureShouldBeRoundedCorner() throws {
        // Arrange
        let profileImageView = try XCTUnwrap(sut.profileImageView, "The profileImageView IBOutlet should be connected")
        // Assert
        XCTAssertEqual(profileImageView.layer.cornerRadius, profileImageView.bounds.height / 2, "The corner radius should be rounded")
    }

    func testGitRepositoryTableViewCell_WhenCellTap_UpdatedTheExpandState() throws {
        // Arrange
        let expandedStack = try XCTUnwrap(sut.expandedUIStackView, "The expandedUIStackView IBOutlet should be connected")
        cellViewModel.isExpanded = true
        sut.viewModel = cellViewModel

        // Assert
        XCTAssertEqual(expandedStack.isHidden, !cellViewModel.isExpanded, "Should be the inverse state for expand and collapse")
    }

    func testGitRepositoryTableViewCell_WhenLoads_LanguageViewShouldBeRoundedCorner() throws {
        // Arrange
        let profileImageView = try XCTUnwrap(sut.languageFlagView, "The languageFlagView IBOutlet should be connected")
        // Assert
        XCTAssertEqual(profileImageView.layer.cornerRadius, profileImageView.bounds.height / 2, "The corner radius should be rounded")
    }
}
