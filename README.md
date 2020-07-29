#  GetYourGuide Coding Challenge

## Summary
Build a single view application that fetches reviews from given `url` and shows review's author, message, title, date and rating. Beside main functional application provides the following functionality:
• fetch more reviews with pagination when the last review is visible 
• load sorted review by date or rating

### Requirements
- iOS 13.0+
- Xcode 11.3.1
- Swift 5

### Installing
No setup is needed to run the project. Simply open project file with mentioned above xcode version and run

### Application

Application is written in Swift with MVVM architecture. SwiftUI was used to implement UI. 
• `ApiClientMock` class provides mocked data to run prject in `preview` mode. 
• pagination `limit` is hardcoded to 10 in `ReviewListViewModel`'s `init` method. 
• show reviews sorted by `date:desc` when no sorting option is specified
 
### Testing
Due to time constraints, as well as was not in requirements, no test were written. However code is written with testability in mind, meaning dependecies are injected in `init` methods. 

