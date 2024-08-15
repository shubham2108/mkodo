# mkodo

It's a sample app designed to display a selection of hardcoded lottery draws.


## Description

The primary purpose of this app is to demonstrate the following:

* Implementation of the MVVM architecture using SwiftUI.
* Handling navigation between views:
    * This is achieved using a `NavigationHandler` class in conjunction with a `Route` enum.
* Loading data from a local JSON file:
    * A `StorageManager` class is used to retrieve data from the JSON file and decode it into the appropriate data model.
    * Basic error handling is included in case of parsing failures.
* Displaying lottery draws.
* Showing draw details when a draw is selected.
* Unit tests that cover all business logic.
* Basic UI tests for elements on the Home screen:
    * Note that it does not include logic to switch between live and mock data.
* Several UI/UX enhancements to improve the overall user experience.
* Add Dummy App icon 
* Add launch screen

## Requirements

* Xcode >= 15
* iOS >= 17.5
* Coding language = Swift & SwiftUI

## Development

Open `mokodo.xcodeproj` in Xcode.


## Unit Testing

To run unit tests, select the `Test navigator` and tap play button infront of `mkodoTests`


## UI Automated Testing

To run Automated tests, select the `Test navigator` and tap play button infront of `mkodoUITests`

## Demo

![Simulator Screen Recording - iPhone 15 Pro - 2024-08-15 at 11 22 02](https://github.com/user-attachments/assets/ff32035b-864a-4ecc-b8f9-e9108a9e4403)
