
# TubeStatusAppTFL

TubeStatusAppTFL is a native iOS application designed to provide real-time information on the status of all London Tube lines. Built using Swift as the primary language and SwiftUI as the frontend framework, the app offers a user-friendly interface for users to stay informed about the operational status of each Tube line.

**Key Features:**

-   **Comprehensive Line Status:** Get instant information on whether each Tube line is running, suspended, or closed, offering a comprehensive overview of the London Tubes Network.

**Technology Stack:**

-   **Language:** Swift
-   **Frontend Framework:** SwiftUI

**How It Works:** 
The app leverages Swift to handle the application logic and SwiftUI for creating an intuitive and responsive user interface. Users can easily navigate through the app to access detailed information about individual Tube lines.

TubeStatusAppTFL ensures a seamless user experience, providing critical information at a glance and helping commuters make informed decisions about their journeys.

**Running and tested Version:**
 - XCode 14.0.1 (14A400)
 - iOS 16.0 deployment target
 - iPhone Landscape and Portrait support
 - MacOS Monterey 12.7.1

**How to build the code?**
 - Checkout the **main** branch
 - Get your primary key from the https://api-portal.tfl.gov.uk/
 - Go to `TubeStatusApp/TubeStatusApp/Configurations/Credentials.swif`
 - `Replace` the value of the variable named `"appKey"` under the `"TFLCredentials"` enum.

**How to run the output?**
 - Clean the *Derived data or cache data* from Xcode location.
 - Open the `TubeStatusApp.xcodeproj` in Xcode.
 - Run the application on iOS 16.0 version on any iPhone model under `TubeStatusApp Scheme`
 - It should display the list of all the tubes and their status in the simulator

**How to run any UI tests?**
UITest methods are written in `TubeStatusAppUITests` file
 - Change the scheme from any to `TubeStatusAppUITests` from the top-mid section of the XCode
 - Go to `TubeStatusAppUITests.swift`
 - Either click on `play` button of *TubeStatusAppUITests* class or enter `Command + U` to run the tests
 - data match expectation test was carried out from UI side.

**How to run any Business Logic or Backend tests?**
BackendTest methods are written in `TubeStatusAppTests` file
 - Change the scheme from any to `TubeStatusAppTests` from the top-mid of the XCode
 - Go to `TubeStatusAppTests.swift`
 - Either click on `play` button of TubeStatusAppTests class or enter `Command + U` to run the tests
 - Latency test, API Result expectation and Performance of API was carried out in the tests.

**Any Assumptions?**
 - This app currently only targets iPhone models and not any other devices
 - No Extra Frameworks were used.
 - My old Macbook doesn't contain USB-C Port so was unable to test this app on iPhone device.
 - The application assumes the continuous availability of the TFL API for retrieving real-time Tube status information.
 - No offline storage of any tubes information was saved.
 - This app currently only support iPhone models.

**Any Relevant Inputs?**
 - It was fun and exciting to work on this project and get to learn many things.
 - Tried to use maximum of enums, struct, combine and protocols to support the protocol-oriented reactive approach.
 - Created a few folders as so to decrease the burden of all logics and it can be splitted in various forms.
 - If the tube status is `"Good service"` then Its font color is shown `green`, else different colors were shown such as `red, blue, black and yellow`.
 - All the tubes are assigned with different bar rectangular color as shown in the assignment

   
