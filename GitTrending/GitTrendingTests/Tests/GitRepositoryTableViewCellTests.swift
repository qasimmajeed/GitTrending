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

}
