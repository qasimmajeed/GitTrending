# GitTrending(TDD)

This application has been implemented using TDD with UIKit and Swift Combine.

## Features

- [x] Shimmer Loading
- [x] Show latest git trending repositories.
- [x] On fail call the retry will be shown.
- [x] Pull to refresh to get the latest data from the api.
- [x] Supports Dark/Light mode.

## View States
<table>
  <tr>
    <td>Loading Shimmer</td>
    <td>Trending Repositories</td>
    <td>Retry</td>
    <td>Dark Mode</td>
  </tr>
  <tr>
  <td><img src="ScreenShots/loading shimmer.png" alt="loading" width="200"/></td>
    <td><img src="ScreenShots/repositories.png" alt="repositories" width="200"/></td>
    <td><img src="ScreenShots/retry.png" alt="retry" width="200"/></td>
    <td><img src="ScreenShots/darkmode.png" alt="darkmode" width="200"/></td>
   </tr>
 </table>

## Technical Details

- [x] Modular based architecture (Network Feature)
- [x] TDD(Unit-testing & UI-testing) tried to maintain more than 90 percent of code coverage
- [x] MVVM with clean using coordinator pattren
- [x] Using of combine

## Requirements

- iOS 13+ 
- Xcode 14+
- Swift 5.5+
- SPM

