//
//  FakeGitRepositoryData.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation
@testable import GitTrending

struct FakeGitRepositoryData {
    
    static let jsonFakeData =  """
{
  "total_count": 1,
  "incomplete_results": false,
  "items": [
    {
      "id": 322462499,
      "node_id": "MDEwOlJlcG9zaXRvcnkzMjI0NjI0OTk=",
      "name": "NUMPY-MATPLOTLIB-lambdaChart",
      "full_name": "how-dev/NUMPY-MATPLOTLIB-lambdaChart",
      "private": false,
      "owner": {
        "login": "how-dev",
        "id": 75768068,
        "node_id": "MDQ6VXNlcjc1NzY4MDY4",
        "avatar_url": "https://avatars.githubusercontent.com/u/75768068?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/how-dev",
        "html_url": "https://github.com/how-dev",
        "followers_url": "https://api.github.com/users/how-dev/followers",
        "following_url": "https://api.github.com/users/how-dev/following{/other_user}",
        "gists_url": "https://api.github.com/users/how-dev/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/how-dev/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/how-dev/subscriptions",
        "organizations_url": "https://api.github.com/users/how-dev/orgs",
        "repos_url": "https://api.github.com/users/how-dev/repos",
        "events_url": "https://api.github.com/users/how-dev/events{/privacy}",
        "received_events_url": "https://api.github.com/users/how-dev/received_events",
        "type": "User",
        "site_admin": false
      },
      "html_url": "https://github.com/how-dev/NUMPY-MATPLOTLIB-lambdaChart",
      "description": " A particle trajectory graph using the Numpy and Matplotlib libraries",
      "fork": false,
      "url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart",
      "forks_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/forks",
      "keys_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/keys{/key_id}",
      "collaborators_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/collaborators{/collaborator}",
      "teams_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/teams",
      "hooks_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/hooks",
      "issue_events_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/issues/events{/number}",
      "events_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/events",
      "assignees_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/assignees{/user}",
      "branches_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/branches{/branch}",
      "tags_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/tags",
      "blobs_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/git/blobs{/sha}",
      "git_tags_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/git/tags{/sha}",
      "git_refs_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/git/refs{/sha}",
      "trees_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/git/trees{/sha}",
      "statuses_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/statuses/{sha}",
      "languages_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/languages",
      "stargazers_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/stargazers",
      "contributors_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/contributors",
      "subscribers_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/subscribers",
      "subscription_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/subscription",
      "commits_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/commits{/sha}",
      "git_commits_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/git/commits{/sha}",
      "comments_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/comments{/number}",
      "issue_comment_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/issues/comments{/number}",
      "contents_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/contents/{+path}",
      "compare_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/compare/{base}...{head}",
      "merges_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/merges",
      "archive_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/{archive_format}{/ref}",
      "downloads_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/downloads",
      "issues_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/issues{/number}",
      "pulls_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/pulls{/number}",
      "milestones_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/milestones{/number}",
      "notifications_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/notifications{?since,all,participating}",
      "labels_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/labels{/name}",
      "releases_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/releases{/id}",
      "deployments_url": "https://api.github.com/repos/how-dev/NUMPY-MATPLOTLIB-lambdaChart/deployments",
      "created_at": "2020-12-18T02:04:06Z",
      "updated_at": "2022-02-22T20:12:28Z",
      "pushed_at": "2020-12-18T02:04:41Z",
      "git_url": "git://github.com/how-dev/NUMPY-MATPLOTLIB-lambdaChart.git",
      "ssh_url": "git@github.com:how-dev/NUMPY-MATPLOTLIB-lambdaChart.git",
      "clone_url": "https://github.com/how-dev/NUMPY-MATPLOTLIB-lambdaChart.git",
      "svn_url": "https://github.com/how-dev/NUMPY-MATPLOTLIB-lambdaChart",
      "homepage": null,
      "size": 0,
      "stargazers_count": 2,
      "watchers_count": 2,
      "language": "Python",
      "has_issues": true,
      "has_projects": true,
      "has_downloads": true,
      "has_wiki": true,
      "has_pages": false,
      "has_discussions": false,
      "forks_count": 0,
      "mirror_url": null,
      "archived": false,
      "disabled": false,
      "open_issues_count": 0,
      "license": null,
      "allow_forking": true,
      "is_template": false,
      "web_commit_signoff_required": false,
      "topics": [

      ],
      "visibility": "public",
      "forks": 0,
      "open_issues": 0,
      "watchers": 2,
      "default_branch": "master",
      "score": 1.0
    }
  ]
}
"""
    static let fakeRepositories = GitRepositoryResponse(items: [Repository.init()])
}

