# Matrix Counter

This repository contains a sample Matrix Counter project developed using the MVVM (Model-View-ViewModel) architectural pattern in Swift. MVVM is commonly used in iOS development to separate concerns and make the codebase more modular and maintainable.

## Overview

The Matrix Counter project consists of the following components:

- **Model**: Represents the data and business logic of the application. It encapsulates the data and behavior of the application's domain.
- **View**: Represents the user interface components and their layout. It is responsible for displaying the data to the user and capturing user input.
- **ViewModel**: Acts as an intermediary between the Model and View. It provides data to the View and handles user interactions. It also contains presentation logic and business logic that is not suitable for the Model.

## Features

- Fetches data from a JSON file and populates the UI.
- Implements a spreadsheet-style view using the SpreadsheetView library.
- Demonstrates the usage of MVVM architecture in iOS development.
- Utilizes Codable for JSON decoding and encoding.
- Uses UIKit for building the user interface components.

## Installation

To run the Matrix Counter project locally, follow these steps:

1. Clone the repository to your local machine using the following command:
https://github.com/surajiosdev23/Matrix_Counter.git

2. Open the project in Xcode by double-clicking on the `matrix-counter.xcodeproj` file.

3. Build and run the project using the Xcode simulator or a physical iOS device.

## Requirements

- Xcode 12 or later
- Swift 5.0 or later

## Credits

- The project utilizes the SpreadsheetView library for creating the spreadsheet-style view. ([SpreadsheetView](https://github.com/kishikawakatsumi/SpreadsheetView))

## License

This project is licensed under the [MIT License](LICENSE).


