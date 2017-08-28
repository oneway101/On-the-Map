# On the Map
This application was developed for the Udacity iOS Developer Nanodegree. It posts user-generated location information to a shared map, pulling the locations of fellow Nanodegree students.


### Features

**Login View**

Allows the user to log in using their Udacity credentials
When the user taps the Login button, the app will attempt to authenticate with Udacity’s servers.

**MapView**

Displays a map with pins specifying the last 100 locations posted by students.

When the user taps a pin, it displays the pin annotation popup, with the student’s name (pulled from their Udacity profile) and the link associated with the student’s pin.

Tapping anywhere within the annotation will launch Safari and direct it to the link associated with the pin.

**TableView**

Displays the most recent 100 locations posted by students in a table.

Each row displays the name from the student’s Udacity profile. Tapping on the row launches Safari and opens the link associated with the student.

**Post Pin**

Allows users to input data in two steps: first adding their location string, then their link.


### Technologies Used In Application

- UINavigationController
- UITableViews
- MKMapViews
- JSON Parsing
- NSURL Sessions
- MVC


### Installation

Download and open .xcodeproj file using XCode. Run the project either with built-in iPhone simulator in Xcode or use your own iPhone device.
